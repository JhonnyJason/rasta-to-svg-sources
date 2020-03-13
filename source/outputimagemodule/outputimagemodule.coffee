outputimagemodule = {name: "outputimagemodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["outputimagemodule"]?  then console.log "[outputimagemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
canvasWidth = 300
canvasHeight = 300

############################################################
canvas = null
context = null

############################################################
outputimagemodule.initialize = () ->
    log "outputimagemodule.initialize"
    # canvas = document.getElementById("outputimage")
    # canvas.width = canvasWidth
    # canvas.height = canvasHeight
    # context = canvas.getContext("2d")
    return

############################################################
outputimagemodule.putImageData = (imageData) ->
    context.clearRect(0,0,canvasWidth, canvasHeight)
    context.putImageData(imageData, 0, 0)
    return

module.exports = outputimagemodule