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

postProcess = null

############################################################
canvasWidth = 300
canvasHeight = 300

############################################################
context = null

############################################################
outputimagemodule.initialize = () ->
    log "outputimagemodule.initialize"
    postProcess = allModules.postprocessimagemodule
    outputimageCanvas.width = canvasWidth
    outputimageCanvas.height = canvasHeight
    context = outputimageCanvas.getContext("2d")
    return

############################################################
outputimagemodule.putImageData = (imageData) ->
    context.clearRect(0,0,canvasWidth, canvasHeight)
    context.putImageData(imageData, 0, 0)
    postProcess.setBackground(outputimageCanvas.toDataURL())
    return

module.exports = outputimagemodule