footermodule = {name: "footermodule"}

#region modulesFromTheEnvironment
utl = null
#endregion

#region printLogFunctions
##############################################################################
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["footermodule"]?  then console.log "[footermodule]: " + arg
    return
print = (arg) -> console.log(arg)
#endregion
##############################################################################
footermodule.initialize = () ->
    log "footermodule.initialize"
    
module.exports = footermodule