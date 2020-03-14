postprocessimagemodule = {name: "postprocessimagemodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["postprocessimagemodule"]?  then console.log "[postprocessimagemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
postprocessimagemodule.initialize = () ->
    log "postprocessimagemodule.initialize"
    return
    
module.exports = postprocessimagemodule