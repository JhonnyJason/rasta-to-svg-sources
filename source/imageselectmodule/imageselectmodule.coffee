imageselectmodule = {name: "imageselectmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["imageselectmodule"]?  then console.log "[imageselectmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
source = null

############################################################
currentMode = "image"

############################################################
imageselectmodule.initialize = () ->
    log "imageselectmodule.initialize"
    source = allModules.sourceimagemodule
    
    #region addEventListeners
    imageselectInput.addEventListener("change", imageselectInputChanged)
    captureButton.addEventListener("click", captureButtonClicked)
    resumeButton.addEventListener("click", resumeButtonClicked)
    #endregion
    return

############################################################
#region eventHandlers
imageselectInputChanged = ->
    log "imageselectInputChanged"
    file = imageselectInput.files[0]
    if file then source.setAsSourceFile(file)
    return

captureButtonClicked = ->
    log "captureIconClicked"
    source.captureCamImage()
    return

resumeButtonClicked = ->
    log "captureIconClicked"
    source.resumeVideo()
    return
#endregion

############################################################
imageselectmodule.setMode = (label) ->
    log "imageselectmodule.setMode"
    currentMode = label
    if label == "cam-captured"
        imageselectArea.className = "cam-captured"
        return
    if label == "cam"
        imageselectArea.className = "cam"
        return
    if label == "image"
        imageselectArea.className = "image"
        return
    return

imageselectmodule.toggleVideoCapture = ->
    log "imageselectmodule.toggleVideoCapture"
    if currentMode == "cam-captured"
        source.resumeVideo()
        return
    if currentMode == "cam"
        source.captureCamImage()
        return
    return


module.exports = imageselectmodule