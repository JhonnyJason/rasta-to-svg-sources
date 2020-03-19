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
postProcess = null

############################################################
maxUint16 = 65535

############################################################
contextFilter = ""
transformConfig = {}
oneChannelData = null

############################################################
transformmodule.initialize = () ->
    log "transformmodule.initialize"
    source = allModules.sourceimagemodule
    output = allModules.outputimagemodule
    postProcess = allModules.postprocessimagemodule
    return

############################################################
#region internalFunctions
runTransformationPipeline = (imageData) ->
    log "runTransformationPipeline"
    return imageData unless transformConfig
    oneChannelData = reduceToOneChannel(imageData)
    if transformConfig.scaleValues then scaleMinMax(oneChannelData)
    binarize(imageData, oneChannelData, transformConfig.binarizeThreshold)
    return imageData

############################################################
#region transformationFunctions
reduceToOneChannel = (imageData) ->
    log "reduceToOneChannel"
    if imageData.data.length % 4 then throw "imageData error: not divisable by 4!"
    reduced = new Uint16Array(imageData.data.length / 4)

    for value,index in imageData.data by 4
        reduced[index/4] = value * imageData.data[index+3]

    return reduced

scaleMinMax = (oneChannelData) ->
    log "scaleMinMax"
    minValue = maxUint16
    maxValue = 0

    for value in oneChannelData
        if value < minValue then minValue = value
        if value > maxValue then maxValue = value
    
    if maxValue == 0 then return # nothing to scale

    # log "minValue: " + minValue
    # log "maxValue: " + maxValue
    usedRange = maxValue - minValue
    scaleFactor = 1.0 * maxUint16 / usedRange
    # log "scaleFactor: " + scaleFactor
    
    for value,index in oneChannelData
        oneChannelData[index] = (value - minValue) * scaleFactor

    # log "after scaling..."

    # for value in oneChannelData
    #     if value < minValue then minValue = value
    #     if value > maxValue then maxValue = value
    
    # log "minValue: " + minValue
    # log "maxValue: " + maxValue
    
    return


binarize = (imageData, oneChannelData, threshold) ->
    log "binarize"
    if imageData.data.length != oneChannelData.length * 4
        throw "Dimension of oneChannelData and imageData did diverge!"

    threshold = maxUint16 * threshold

    for value,index in oneChannelData
        dataBase = index*4
        if value > threshold 
            imageData.data[dataBase] = 255
            imageData.data[dataBase+1] = 255
            imageData.data[dataBase+2] = 255
            imageData.data[dataBase+3] = 255
            oneChannelData[index] = maxUint16
        else
            imageData.data[dataBase] = 0
            imageData.data[dataBase+1] = 0
            imageData.data[dataBase+2] = 0
            imageData.data[dataBase+3] = 0
            oneChannelData[index] = 0
    return

#endregion

#endregion

############################################################
#region exposedFunctions
transformmodule.act = ->
    log "transformmodule.act"
    source.setContextFilter(contextFilter)
    imageData = source.getImageData()
    imageData = runTransformationPipeline(imageData)
    postProcess.setChannelToProcess(oneChannelData)
    output.putImageData(imageData)
    return

############################################################
transformmodule.adjustContextFilter = (configObject) ->
    log "transformmodule.adjustContextFilter"
    contextFilter = ""
    contextFilter += "blur("+configObject.blur+"px) "
    contextFilter += "contrast("+configObject.contrast+"%) "
    contextFilter += "saturate("+configObject.saturate+"%) "
    if configObject.grayscale then contextFilter += "grayscale(1) "
    if configObject.invert then contextFilter += "invert(1) "
    log contextFilter 
    return

transformmodule.adjustTransformationPipeline = (configObject) ->
    log "transformmodule.adjustTransformationPipeline"
    transformConfig.scaleValues = configObject.scaleValues

    threshold = 0.01 * parseInt(configObject.binarizeThreshold)
    transformConfig.binarizeThreshold = threshold
    # olog transformConfig
    return
    
#endregion

module.exports = transformmodule