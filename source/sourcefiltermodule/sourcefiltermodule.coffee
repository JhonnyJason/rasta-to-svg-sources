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
processPipeline = null
transform = null
state = null

############################################################
defaultContextConfig = 
    blur: "0.7"
    contrast: "300"
    saturate: "100"
    grayscale: true
    invert: true
contextConfigObject = Object.assign({}, defaultContextConfig)

############################################################
isHidden = true

############################################################
sourcefiltermodule.initialize = () ->
    log "sourcefiltermodule.initialize"
    processPipeline = allModules.processpipelinemodule
    transform = allModules.transformmodule
    state = allModules.uistatemodule

    blurInput.addEventListener("change", blurInputChanged)
    blurRangeInput.addEventListener("change", blurRangeInputChanged)
    contrastInput.addEventListener("change", contrastInputChanged)
    contrastRangeInput.addEventListener("change", contrastRangeInputChanged)
    saturateInput.addEventListener("change", saturateInputChanged)
    saturateRangeInput.addEventListener("change", saturateRangeInputChanged)
    grayscaleInput.addEventListener("change", grayscaleInputChanged)
    invertInput.addEventListener("change", invertInputChanged)
    sourcefilterResetButton.addEventListener("click", resetButtonClicked)

    savedConfig = state.getState().sourceFilterConfig
    if savedConfig then contextConfigObject = savedConfig
    
    savedHiddenState = state.getState().sourceFilterHidden
    if typeof savedHiddenState == "boolean" and savedHiddenState == false
        sourcefilterControl.classList.remove "hidden"
        isHidden = savedHiddenState

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
    blurRangeInput.value = contextConfigObject.blur
    contrastInput.value = contextConfigObject.contrast
    contrastRangeInput.value = contextConfigObject.contrast
    saturateInput.value = contextConfigObject.saturate
    saturateRangeInput.value = contextConfigObject.saturate
    grayscaleInput.checked = contextConfigObject.grayscale
    invertInput.checked = contextConfigObject.invert
    return

propagateValues = ->
    log "propagateValues"
    state.saveSourceFilterState(contextConfigObject)
    transform.adjustContextFilter(contextConfigObject)
    processPipeline.act()
    return

############################################################
#region eventListeners
blurRangeInputChanged = ->
    log "blurRangeInputChanged"
    value = blurRangeInput.value
    blurInput.value = value
    contextConfigObject.blur = value
    propagateValues()
    return

blurInputChanged = ->
    log "blurInputChanged"
    value = blurInput.value
    blurRangeInput.value = value
    contextConfigObject.blur = value
    propagateValues()
    return

contrastRangeInputChanged = ->
    log "contrastRangeInputChanged"
    value = contrastRangeInput.value
    contrastInput.value = value
    contextConfigObject.contrast = value
    propagateValues()
    return

contrastInputChanged = ->
    log "contrastInputChanged"
    value = contrastInput.value
    contrastRangeInput.value = value
    contextConfigObject.contrast = value
    propagateValues()
    return

saturateRangeInputChanged = ->
    log "saturateRangeInputChanged"
    value = saturateRangeInput.value
    saturateInput.value = value
    contextConfigObject.saturate = value
    propagateValues()
    return

saturateInputChanged = ->
    log "saturateInputChanged"
    value = saturateInput.value
    saturateRangeInput.value = value
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
        sourcefilterControl.classList.remove "hidden"
        isHidden = false
    else
        sourcefilterControl.classList.add "hidden"
        isHidden = true
    state.saveSourceFilterHiddenState(isHidden)
    return isHidden

module.exports = sourcefiltermodule