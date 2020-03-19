uistatemodule = {name: "uistatemodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["uistatemodule"]?  then console.log "[uistatemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
uistate = localStorage.getItem("uistate")
if uistate then uistate = JSON.parse(uistate)
else uistate = {}

############################################################
uistatemodule.initialize = () ->
    log "uistatemodule.initialize"
    return

############################################################
saveState = ->
    log "saveState"
    stateString = JSON.stringify(uistate)
    localStorage.setItem("uistate", stateString)
    return

############################################################
#region exposedFunctions
uistatemodule.getState = -> uistate

############################################################
#region hiddenUIStates
uistatemodule.saveSourceFilterHiddenState = (isHidden) ->
    log "uistatemodule.saveSourceFilterHiddenState"
    uistate.sourceFilterHidden = isHidden
    saveState()
    return

uistatemodule.saveOutputFilterHiddenState = (isHidden) ->
    log "uistatemodule.saveOutputFilterHiddenState"
    uistate.outputFilterHidden = isHidden
    saveState()
    return

uistatemodule.saveProcessSettingsHiddenState = (isHidden) ->
    log "uistatemodule.saveProcessSettingsHiddenState"
    uistate.processSettingsHidden = isHidden
    saveState()
    return

#endregion

############################################################
#region settings
uistatemodule.saveSourceFilterState = (configObject) ->
    log "uistatemodule.saveSourceFilterState"
    uistate.sourceFilterConfig = configObject
    saveState()
    return

uistatemodule.saveOutputFilterState = (configObject) ->
    log "uistatemodule.saveOutputFilterState"
    uistate.outputFilterConfig = configObject
    saveState()
    return

uistatemodule.saveProcessSettingsState = (configObject) ->
    log "uistatemodule.saveProcessSettingsState"
    uistate.processSettings = configObject
    saveState()
    return

#endregion

############################################################
uistatemodule.saveMenuState = (stateObject) ->
    log "uistatemodule.saveMenuState"
    uistate.menuState = stateObject
    saveState()
    return

uistatemodule.saveViewState = (stateObject) ->
    log "uistatemodule.saveViewState"
    uistate.viewState = stateObject
    saveState()
    return

#endregion

module.exports = uistatemodule