layoutmanagermodule = {name: "layoutmanagermodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["layoutmanagermodule"]?  then console.log "[layoutmanagermodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
state = null

############################################################
viewState = null

############################################################
layoutmanagermodule.initialize = () ->
    log "layoutmanagermodule.initialize"
    state = allModules.uistatemodule
    viewState = state.getState().viewState
    if viewState then document.body.className = viewState 
    return

############################################################
layoutmanagermodule.checkPossibleLayout = ->
    log "layoutmanagermodule.checkPossibleLayout"
    return

layoutmanagermodule.viewAll = ->
    log "layoutmanagermodule.viewAll"
    viewState = "view-all"
    document.body.className = viewState
    state.saveViewState viewState
    return

layoutmanagermodule.viewSource = ->
    log "layoutmanagermodule.viewSource"
    viewState = "view-source"
    document.body.className = viewState
    state.saveViewState viewState
    return

layoutmanagermodule.viewOutput = ->
    log "layoutmanagermodule.viewOutput"
    viewState = "view-output"
    document.body.className = viewState
    state.saveViewState viewState
    return

layoutmanagermodule.viewPostProcess = ->
    log "layoutmanagermodule.viewPostProcess"
    viewState = "view-postprocess"
    document.body.className = viewState
    state.saveViewState viewState
    return

module.exports = layoutmanagermodule