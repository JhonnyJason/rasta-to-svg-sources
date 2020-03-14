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

############################################################
#region definitions
canvasWidth = 300
canvasHeight = 300
framerate = 24
#endregion

############################################################
intervalId = 0

videoDevice = null
redrawImage = new Image()
context = null

activeSource = "image"

############################################################
sourceimagemodule.initialize = () ->
    log "sourceimagemodule.initialize"
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
    context.clearRect(0,0,canvasWidth, canvasHeight)
    context.drawImage(hiddenSourceImage, 0, 0, canvasWidth, canvasHeight)
    captureRedrawImage()
    return

drawVideoToContext = ->
    context.clearRect(0,0,canvasWidth, canvasHeight)
    context.drawImage(hiddenSourceVideo, 0, 0, canvasWidth, canvasHeight)
    captureRedrawImage()
    return

############################################################
captureRedrawImage = ->
    dataURL = sourceimageCanvas.toDataURL("image/png")
    redrawImage.src = dataURL
    return

imageLoaded = ->
    log "imageLoaded"
    drawImageToContext()
    transform.act()
    return

############################################################
startVideoDrawing = ->
    log "startVideoDrawing"
    return if intervalId
    intervalId = setInterval(drawVideoToContext, 1.0 / framerate)
    return

stopVideoDrawing = ->
    log "stopVideoDrawing"
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
    context.filter = filter
    context.clearRect(0,0,canvasWidth, canvasHeight)
    context.drawImage(redrawImage, 0, 0, canvasWidth, canvasHeight)
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
    transform.act()
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