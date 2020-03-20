postprocesssettingsmodule = {name: "postprocesssettingsmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["postprocesssettingsmodule"]?  then console.log "[postprocesssettingsmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
processPipeline = null
state = null

############################################################
controlsAreHidden = true

defaultConfigObject = {minimalVolume: 400}
configObject = Object.assign({}, defaultConfigObject)

############################################################
postprocesssettingsmodule.initialize = () ->
    log "postprocesssettingsmodule.initialize"
    processPipeline = allModules.processpipelinemodule
    state = allModules.uistatemodule

    minimalVolumeInput.addEventListener("change", minimalVolumeInputChanged)
    minimalVolumeRangeInput.addEventListener("change", minimalVolumeRangeInputChanged)

    postprocesssettingsResetButton.addEventListener("click", resetValues)

    savedConfig = state.getState().processSettings
    if savedConfig then configObject = savedConfig

    savedHiddenState = state.getState().processSettingsHidden
    if typeof savedHiddenState == "boolean" and savedHiddenState == false
        postprocesssettingsControl.classList.remove "hidden"
        controlsAreHidden = savedHiddenState

    assignCurrentValues()
    return

############################################################
#region internalFunctions
resetValues = ->
    log "resetValues"
    configObject = Object.assign({}, defaultConfigObject)
    assignCurrentValues()
    propagateValues()
    return

assignCurrentValues = ->
    log "assignCurrentValues"
    minimalVolumeInput.value = configObject.minimalVolume
    minimalVolumeRangeInput.value = configObject.minimalVolume
    return

propagateValues = ->
    log "propagateValues"
    state.saveProcessSettingsState(configObject)
    processPipeline.actPostProcess()
    return

############################################################
minimalVolumeInputChanged = ->
    log "minimalVolumeInputChanged"
    value = minimalVolumeInput.value
    minimalVolumeRangeInput.value = value
    configObject.minimalVolume = value
    propagateValues()
    return

minimalVolumeRangeInputChanged = ->
    log "minimalVolumeRangeInputChanged"
    value = minimalVolumeRangeInput.value
    minimalVolumeInput.value = value
    configObject.minimalVolume = value
    propagateValues()
    return

#endregion

############################################################
postprocesssettingsmodule.toggleHiddenControls = ->
    log "postprocesssettingsmodule.toggleHiddenControls"
    if controlsAreHidden
        postprocesssettingsControl.classList.remove("hidden")
        controlsAreHidden = false
    else
        postprocesssettingsControl.classList.add("hidden")
        controlsAreHidden = true

    state.saveProcessSettingsHiddenState(controlsAreHidden)
    return controlsAreHidden

postprocesssettingsmodule.getMinimalVolume = -> 
    return parseInt(configObject.minimalVolume)

module.exports = postprocesssettingsmodule
