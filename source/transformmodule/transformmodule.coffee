transformmodule = {name: "transformmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["transformmodule"]?  then console.log "[transformmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
canvasFilters = require "canvas-filters"

############################################################
source = null
output = null

############################################################
contextFilter = ""

############################################################
transformmodule.initialize = () ->
    log "transformmodule.initialize"
    source = allModules.sourceimagemodule
    output = allModules.outputimagemodule
    return

############################################################
getMaxGrayValue = (imageData, minAcceptedGrayValue = 10) ->
    log "getMaxGrayValue"
    maxGrayValue = 10
    for value,index in imageData.data by 4
        if value > 0 then imageData.data[index + 3] = 255
        else 
            imageData.data[index] = 0
            imageData.data[index+1] = 0
            imageData.data[index+2] = 0
            imageData.data[index+3] = 0
        if value > maxGrayValue then maxGrayValue = value
    return maxGrayValue

scaleColorValues = (imageData, factor) ->
    log "scaleColorValues"
    for value,index in imageData.data by 4
        imageData.data[index] *= factor
        imageData.data[index+1] *= factor
        imageData.data[index+2] *= factor
    return

scaleToMaxGrayValue = (imageData) ->
    log "scaleToMaxGrayValue"
    maxGrayValue = getMaxGrayValue(imageData)
    log maxGrayValue
    factor = (1.0 / maxGrayValue) * 255    
    log factor
    if factor > 1.01 then scaleColorValues(imageData, factor)
    return

runTransformationPipeline = (imageData) ->
    log "runTransformationPipeline"
    # scaleToMaxGrayValue(imageData)
    # imageData = canvasFilters.Edge(imageData)
    imageData = canvasFilters.Binarize(imageData)    
    return imageData

############################################################
transformmodule.adjustContextFilter = (configObject) ->
    log "transformmodule.adjustContextFilter"
    contextFilter = ""
    contextFilter += "blur("+configObject.blur+"px) "
    contextFilter += "contrast("+configObject.contrast+"%) "
    contextFilter += "saturate("+configObject.blur+"%) "
    if configObject.grayscale then contextFilter += "grayscale(1) "
    if configObject.invert then contextFilter += "invert(1) "    
    return

transformmodule.adjustTransformationPipeline = (configObject) ->
    log "transformmodule.adjustTransformationPipeline"

    return
    
transformmodule.act = ->
    log "transformmodule.act"
    # source.setContextFilter(contextFilter)
    # imageData = source.getImageData()
    # imageData = runTransformationPipeline(imageData)
    # output.putImageData(imageData)
    return

module.exports = transformmodule