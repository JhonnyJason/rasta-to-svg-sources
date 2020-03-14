sourcefiltermodule = {name: "sourcefiltermodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["sourcefiltermodule"]?  then console.log "[sourcefiltermodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
transform = null

############################################################
defaultContextConfig = 
    blur: "1"
    contrast: "250"
    saturate: "200"
    grayscale: true
    invert: true
contextConfigObject = Object.assign({}, defaultContextConfig)

############################################################
isHidden = true

############################################################
sourcefiltermodule.initialize = () ->
    log "sourcefiltermodule.initialize"
    transform = allModules.transformmodule

    blurInput.addEventListener("change", blurInputChanged)
    contrastInput.addEventListener("change", contrastInputChanged)
    saturateInput.addEventListener("change", saturateInputChanged)
    grayscaleInput.addEventListener("change", grayscaleInputChanged)
    invertInput.addEventListener("change", invertInputChanged)
    sourcefilterResetButton.addEventListener("click", resetButtonClicked)

    assignCurrentValues()
    transform.adjustContextFilter(contextConfigObject)
    return

############################################################
#region internalFunctions
resetValues = ->
    log "resetValues"
    contextConfigObject = Object.assign({}, defaultContextConfig)
    assignCurrentValues()
    propagateValues()
    return

assignCurrentValues = ->
    log "assignCurrentValues"
    blurInput.value = contextConfigObject.blur
    contrastInput.value = contextConfigObject.contrast
    saturateInput.value = contextConfigObject.saturate
    grayscaleInput.checked = contextConfigObject.grayscale
    invertInput.checked = contextConfigObject.invert
    return

propagateValues = ->
    log "propagateValues"
    transform.adjustContextFilter(contextConfigObject)
    transform.act()
    return

############################################################
#region eventListeners
blurInputChanged = ->
    log "blurInputChanged"
    value = blurInput.value
    contextConfigObject.blur = value
    propagateValues()
    return

contrastInputChanged = ->
    log "contrastInputChanged"
    value = contrastInput.value
    contextConfigObject.contrast = value
    propagateValues()
    return

saturateInputChanged = ->
    log "saturateInputChanged"
    value = saturateInput.value
    contextConfigObject.saturate = value
    propagateValues()
    return

grayscaleInputChanged = ->
    log "grayscaleInputChanged"
    value = grayscaleInput.checked
    contextConfigObject.grayscale = value
    propagateValues()
    return

invertInputChanged = ->
    log "invertInputChanged"
    value = invertInput.checked
    contextConfigObject.invert = value
    propagateValues()
    return

resetButtonClicked = ->
    log "resetButtonClicked"
    resetValues()
    return
#endregion

#endregion

############################################################
sourcefiltermodule.toggleHidden = ->
    log "sourcefiltermodule.toggleHidden"
    if isHidden
        sourcefilterControl.className = ""
        isHidden = false
    else
        sourcefilterControl.className = "hidden"
        isHidden = true
    return isHidden

module.exports = sourcefiltermodule