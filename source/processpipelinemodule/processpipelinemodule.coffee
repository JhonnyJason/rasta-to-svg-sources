processpipelinemodule = {name: "processpipelinemodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["processpipelinemodule"]?  then console.log "[processpipelinemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
#region internalProperties
transform = null
postProcess = null

############################################################
#region propertiesForActingCorrectly ;-)
intervalId = null

isToAct = false
isToActAll = false
isToActPostProcess = false

pipelineStartTimeMS = 0
pipelineStopTimeMS = 0

multiplier = 3
minimalAdjustmentDistanceMS = 300
minimalActFrequencyMS = 300
actFrequencyMS = 300

#endregion

#endregion

############################################################
processpipelinemodule.initialize = () ->
    log "processpipelinemodule.initialize"
    transform = allModules.transformmodule
    postProcess = allModules.postprocessimagemodule
    resetActInterval()
    return

############################################################
resetActInterval = ->
    log "resetActInterval"
    log "to: " + actFrequencyMS + "ms"
    if intervalId then clearInterval(intervalId)
    intervalId = setInterval(actNow, actFrequencyMS)
    return

recalibrateFrequency = ->
    log "recalibrateFrequency"
    diff = pipelineStopTimeMS - pipelineStartTimeMS
    niceActFrequency = diff * multiplier
    distanceMS = actFrequencyMS - niceActFrequency
    log "distance was " + distanceMS + "ms"
    if Math.abs(distanceMS) <= minimalAdjustmentDistanceMS then return
    
    if niceActFrequency < minimalActFrequencyMS
        return if actFrequencyMS == minimalActFrequencyMS
        actFrequencyMS = minimalActFrequencyMS
        resetActInterval()
        return
        
    actFrequencyMS = niceActFrequency
    resetActInterval()
    return

actNow = ->
    return unless isToAct
    if isToActAll then actAll()
    if isToActPostProcess then actPostProcess()
    isToAct = false
    return

actAll = ->
    pipelineStartTimeMS = performance.now()
    transform.act()
    postProcess.act()
    pipelineStopTimeMS = performance.now()
    recalibrateFrequency()
    isToActAll = false
    isToActPostProcess = false
    return

actPostProcess = ->
    postProcess.act()
    isToActPostProcess = false
    return

############################################################
processpipelinemodule.act = ->
    log "processpipelinemodule.act"
    isToAct = true
    isToActAll = true
    return

processpipelinemodule.actPostProcess = ->
    log "processpipelinemodule.actPostProcess"
    isToAct = true
    isToActPostProcess = true
    return

module.exports = processpipelinemodule