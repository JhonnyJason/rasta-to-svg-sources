outputfiltermodule = {name: "outputfiltermodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["outputfiltermodule"]?  then console.log "[outputfiltermodule]: " + arg
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
    scaleValues: true
    binarizeThreshold: "80"
contextConfigObject = Object.assign({}, defaultContextConfig)

############################################################
isHidden = true

############################################################
outputfiltermodule.initialize = () ->
    log "outputfiltermodule.initialize"
    processPipeline = allModules.processpipelinemodule
    transform = allModules.transformmodule
    state = allModules.uistatemodule

    scaleValuesInput.addEventListener("change", scaleValuesInputChanged)
    binarizeThresholdInput.addEventListener("change", binarizeThresholdInputChanged)
    binarizeThresholdRangeInput.addEventListener("change", binarizeThresholdRangeInputChanged)
    outputfilterResetButton.addEventListener("click", resetButtonClicked)

    savedConfig = state.getState().outputFilterConfig
    if savedConfig then contextConfigObject = savedConfig

    savedHiddenState = state.getState().outputFilterHidden
    if typeof savedHiddenState == "boolean" and savedHiddenState == false
        outputfilterControl.classList.remove "hidden"
        isHidden = savedHiddenState

    assignCurrentValues()
    transform.adjustTransformationPipeline(contextConfigObject)
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
    scaleValuesInput.checked = contextConfigObject.scaleValues
    binarizeThresholdInput.value = contextConfigObject.binarizeThreshold
    binarizeThresholdRangeInput.value = contextConfigObject.binarizeThreshold
    return

propagateValues = ->
    log "propagateValues"
    state.saveOutputFilterState(contextConfigObject)
    transform.adjustTransformationPipeline(contextConfigObject)
    processPipeline.act()
    return

############################################################
#region eventListeners
scaleValuesInputChanged = ->
    log "scaleValuesInputChanged"
    value = scaleValuesInput.checked
    contextConfigObject.scaleValues = value
    propagateValues()
    return

binarizeThresholdRangeInputChanged = ->
    log "binarizeThresholdRangeInputChanged"
    value = binarizeThresholdRangeInput.value
    binarizeThresholdInput.value = value
    contextConfigObject.binarizeThreshold = value
    propagateValues()
    return

binarizeThresholdInputChanged = ->
    log "binarizeThresholdInputChanged"
    value = binarizeThresholdInput.value
    binarizeThresholdRangeInput.value = value
    contextConfigObject.binarizeThreshold = value
    propagateValues()
    return

resetButtonClicked = ->
    log "resetButtonClicked"
    resetValues()
    return
#endregion

#endregion

############################################################
outputfiltermodule.toggleHidden = ->
    log "outputfiltermodule.setActive"
    if isHidden
        outputfilterControl.classList.remove("hidden")
        isHidden = false
    else
        outputfilterControl.classList.add("hidden")
        isHidden = true

    state.saveOutputFilterHiddenState(isHidden)
    return isHidden

module.exports = outputfiltermodule