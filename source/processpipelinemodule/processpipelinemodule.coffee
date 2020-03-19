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

transform = null
postProcess = null

isToAct = false

intervalId = null

pipelineStartTimeMS = 0
pipelineStopTimeMS = 0

multiplier = 10
minimalAdjustmentDistanceMS = 300
minimalActFrequencyMS = 500
actFrequencyMS = 1000

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
    pipelineStartTimeMS = performance.now()
    transform.act()
    postProcess.act()
    pipelineStopTimeMS = performance.now()
    recalibrateFrequency()
    isToAct = false
    return

############################################################
processpipelinemodule.act = ->
    log "processpipelinemodule.act"
    isToAct = true
    return

module.exports = processpipelinemodule