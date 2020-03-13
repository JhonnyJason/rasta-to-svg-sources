upbuttonmodule = {name: "upbuttonmodule"}

#region modulesFromTheEnvironment
utl = null
#endregion

#region HTMLElements
upbutton = null
#endregion

#region printLogFunctions
##############################################################################
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["upbuttonmodule"]?  then console.log "[upbuttonmodule]: " + arg
    return
print = (arg) -> console.log(arg)
#endregion
##############################################################################
upbuttonmodule.initialize = () ->
    log "upbuttonmodule.initialize"
    utl = allModules.vanillautilmodule
    upbutton = document.getElementById("up-button")
    if upbutton then upbutton.addEventListener("click", upbuttonClicked)
    return
    
#region internalFunctions
upbuttonClicked = ->
    log "upbuttonClicked"
    utl.scrollTo(0)
    return
#endregion

#region exposedFunctions
#endregion

module.exports = upbuttonmodule