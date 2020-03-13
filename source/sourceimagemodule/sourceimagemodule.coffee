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

############################################################
#region definitions
canvasWidth = 300
canvasHeight = 300
framerate = 24
#endregion

############################################################
#region HTMLElements
canvas = null
context = null
image = null
video = null
#endregion

############################################################
intervalId = 0
redrawImage = new Image()

############################################################
sourceimagemodule.initialize = () ->
    log "sourceimagemodule.initialize"
    transform = allModules.transformmodule

    canvas = document.getElementById("sourceimage")
    image = document.getElementById("hidden-source-image")
    video = document.getElementById("hidden-source-video")
    # image.addEventListener("load", imageLoaded)
    # fast fix untuitive capture of video ;-)
    # canvas.addEventListener("click", sourceimagemodule.captureCamImage)

    # canvas.width = canvasWidth
    # canvas.height = canvasHeight
    # context = canvas.getContext("2d");
    # # context.drawImage(image, 7, 35, 290, 66);
    # drawImageToContext()
    return
    
############################################################
#region internalFunctions
captureRedrawImage = ->
    dataURL = canvas.toDataURL("image/png")
    redrawImage.src = dataURL
    return

drawImageToContext = ->
    log "drawImage"
    context.clearRect(0,0,canvasWidth, canvasHeight)
    context.drawImage(image, 0, 0, canvasWidth, canvasHeight)
    captureRedrawImage()
    return

startVideoDrawing = ->
    log "startVideoDrawing"
    intervalId = setInterval(drawVideoToContext, 1.0 / framerate)
    return

stopVideoDrawing = ->
    log "stopVideoDrawing"
    if intervalId
        clearInterval(intervalId)
        intervalId = 0
    return

drawVideoToContext = ->
    context.clearRect(0,0,canvasWidth, canvasHeight)
    context.drawImage(video, 0, 0, canvasWidth, canvasHeight)
    captureRedrawImage()
    return

imageLoaded = ->
    log "imageLoaded"
    drawImageToContext()
    transform.act()
    return

#endregion

############################################################
#region exposedFunctions
sourceimagemodule.setContextFilter = (filter) ->
    # context.filter = filter
    # context.clearRect(0,0,canvasWidth, canvasHeight)
    # context.drawImage(redrawImage, 0, 0, canvasWidth, canvasHeight)
    return

sourceimagemodule.getImageData = ->
    # return context.getImageData(0,0, canvasWidth, canvasHeight)

############################################################
sourceimagemodule.setAsSourceFile = (file) ->
    log "sourceimagemodule.setAsSourceFile"
    image.src = URL.createObjectURL(file)
    return

sourceimagemodule.captureCamImage = ->
    log "sourceimagemodule.captureCamImage"
    stopVideoDrawing()
    transform.act()
    return

############################################################
sourceimagemodule.setImageAsSource = ->
    log "sourceimagemodule.setImageAsSource"
    stopVideoDrawing()
    image.addEventListener("load", imageLoaded)
    imageLoaded()
    return

sourceimagemodule.setCamAsSource = ->
    log "sourceimagemodule.setCamAsSource"
    image.removeEventListener("load", imageLoaded)
    constraints = 
        video: { facingMode: { ideal: "environment"} }
    videoDevice = await navigator.mediaDevices.getUserMedia(constraints) 
    video.srcObject = videoDevice
    startVideoDrawing()
    return

#endregion

module.exports = sourceimagemodule