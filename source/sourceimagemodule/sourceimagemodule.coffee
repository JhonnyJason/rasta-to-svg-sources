sourceimagemodule = {name: "sourceimagemodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["sourceimagemodule"]?  then console.log "[sourceimagemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
transform = null
imageselect = null
processPipeline = null

############################################################
#region definitions
canvasWidth = 300
canvasHeight = 300
framerate = 24
#endregion

############################################################
intervalId = 0

videoDevice = null
videoCaptureContext = null
context = null

activeSource = "image"

############################################################
sourceimagemodule.initialize = () ->
    log "sourceimagemodule.initialize"
    processPipeline = allModules.processpipelinemodule
    transform = allModules.transformmodule
    imageselect = allModules.imageselectmodule

    hiddenSourceImage.addEventListener("load", imageLoaded)
    sourceimageCanvas.addEventListener("click", imageselect.toggleVideoCapture)

    sourceimageCanvas.width = canvasWidth
    sourceimageCanvas.height = canvasHeight
    context = sourceimageCanvas.getContext("2d");

    drawImageToContext()
    return
    
############################################################
#region internalFunctions
############################################################
#region drawFunctions
drawImageToContext = ->
    log "drawImage"
    #takes 0.3-3ms
    context.clearRect(0,0, canvasWidth, canvasHeight)
    context.drawImage(hiddenSourceImage, 0, 0, canvasWidth, canvasHeight)
    return

drawVideoToContext = ->
    #takes 0.3-3ms
    context.clearRect(0,0,canvasWidth, canvasHeight)
    context.drawImage(hiddenSourceVideo, 0, 0, canvasWidth, canvasHeight)
    return

############################################################
imageLoaded = ->
    log "imageLoaded"
    drawImageToContext()
    processPipeline.act()
    return

############################################################
startVideoDrawing = ->
    log "startVideoDrawing"
    hiddenSourceVideo.play()
    return if intervalId
    intervalId = setInterval(drawVideoToContext, 1.0 / framerate)
    return

stopVideoDrawing = ->
    log "stopVideoDrawing"
    hiddenSourceVideo.pause()
    if intervalId
        clearInterval(intervalId)
        intervalId = 0
    return

#endregion

############################################################
#region sourceSwitchFunctions
setImageAsSource = ->
    log "setImageAsSource"
    return if activeSource == "image"
    imageselect.setMode("image")
    stopVideoDrawing()
    stopCam()
    hiddenSourceImage.addEventListener("load", imageLoaded)
    activeSource = "image"
    imageLoaded()
    return

setCamAsSource = ->
    log "setCamAsSource"
    return if activeSource == "cam"
    imageselect.setMode("cam")
    hiddenSourceImage.removeEventListener("load", imageLoaded)
    constraints = 
        video: { facingMode: { ideal: "environment"} }
    videoDevice = await navigator.mediaDevices.getUserMedia(constraints) 
    hiddenSourceVideo.srcObject = videoDevice
    startVideoDrawing()
    activeSource = "cam"
    return

############################################################
stopCam = ->
    log "stopCam"
    return unless activeSource == "cam"
    hiddenSourceVideo.pause()
    hiddenSourceVideo.src = ""
    track.stop() for track in videoDevice.getTracks()
    return

#endregion

#endregion

############################################################
#region exposedFunctions
sourceimagemodule.setContextFilter = (filter) ->
    log "sourceimagemodule.setContextFilter"
    context.filter = filter
    if activeSource == "image" then drawImageToContext()
    if activeSource == "cam" then drawVideoToContext()
    return

sourceimagemodule.getImageData = ->
    return context.getImageData(0,0, canvasWidth, canvasHeight)

############################################################
sourceimagemodule.setAsSourceFile = (file) ->
    log "sourceimagemodule.setAsSourceFile"
    hiddenSourceImage.src = URL.createObjectURL(file)
    return

sourceimagemodule.captureCamImage = ->
    log "sourceimagemodule.captureCamImage"
    return unless activeSource == "cam"
    imageselect.setMode("cam-captured")
    stopVideoDrawing()
    processPipeline.act()
    return

sourceimagemodule.resumeVideo = ->
    log "sourceimagemodule.captureCamImage"
    return unless activeSource == "cam"
    imageselect.setMode("cam")
    startVideoDrawing()
    return

############################################################
sourceimagemodule.setSource = (label) ->
    log "sourceimagemodule.setSource"
    if label == "image"
        setImageAsSource()
        return "image"
    if label == "cam"
        try 
            setCamAsSource()
            return "cam"
        catch err
            log err
            setImageAsSource()
            return "image"
    return

#endregion

module.exports = sourceimagemodule