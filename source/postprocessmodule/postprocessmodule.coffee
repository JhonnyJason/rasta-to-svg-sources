postprocessmodule = {name: "postprocessmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["postprocessmodule"]?  then console.log "[postprocessmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
controlsAreHidden = true

############################################################
postprocessmodule.initialize = () ->
    log "postprocessmodule.initialize"
    return

############################################################
postprocessmodule.toggleHiddenControls = ->
    log "postprocessmodule.toggleHiddenControls"
    if controlsAreHidden
        postprocessControl.classList.remove("hidden")
        controlsAreHidden = false
        return false
    else
        postprocessControl.classList.add("hidden")
        controlsAreHidden = true
        return true

module.exports = postprocessmodule