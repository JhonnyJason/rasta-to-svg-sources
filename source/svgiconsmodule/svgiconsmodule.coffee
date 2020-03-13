svgiconsmodule = {name: "svgiconsmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["svgiconsmodule"]?  then console.log "[svgiconsmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
svgiconsmodule.initialize = () ->
    log "svgiconsmodule.initialize"
    return
    
module.exports = svgiconsmodule