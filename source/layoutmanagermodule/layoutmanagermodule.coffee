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
layoutmanagermodule.initialize = () ->
    log "layoutmanagermodule.initialize"
    return

############################################################
layoutmanagermodule.checkPossibleLayout = ->
    log "layoutmanagermodule.checkPossibleLayout"
    return

layoutmanagermodule.viewAll = ->
    log "layoutmanagermodule.viewAll"
    document.body.className = "view-all"
    return

layoutmanagermodule.viewSource = ->
    log "layoutmanagermodule.viewSource"
    document.body.className = "view-source"
    return

layoutmanagermodule.viewOutput = ->
    log "layoutmanagermodule.viewOutput"
    document.body.className = "view-output"
    return

layoutmanagermodule.viewPostProcess = ->
    log "layoutmanagermodule.viewPostProcess"
    document.body.className = "view-postprocess"
    return

module.exports = layoutmanagermodule