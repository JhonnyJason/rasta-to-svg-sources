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
imageselect = null
imageselectInput = null
captureIcon = null

############################################################
source = null

############################################################
imageselectmodule.initialize = () ->
    log "imageselectmodule.initialize"
    source = allModules.sourceimagemodule
    
    imageselect = document.getElementById("imageselect")
    imageselectInput = document.getElementById("imageselect-input")
    captureIcon = document.getElementById("capture-icon")

    # imageselectInput.addEventListener("change", imageselectInputChanged)
    # captureIcon.addEventListener("click", captureIconClicked)

    # imageselect.classList.add("image")
    return

############################################################
imageselectInputChanged = ->
    log "imageselectInputChanged"
    file = imageselectInput.files[0]
    if file then source.setAsSourceFile(file)
    return

captureIconClicked = ->
    log "captureIconClicked"
    source.captureCamImage()
    return

############################################################
imageselectmodule.setMode = (label) ->
    log "imageselectmodule.setMode"
    if label == "cam"
        imageselect.classList.add("cam")
        imageselect.classList.remove("image")
        return
    if label == "image"
        imageselect.classList.add("image")
        imageselect.classList.remove("cam")
        return
    return

module.exports = imageselectmodule