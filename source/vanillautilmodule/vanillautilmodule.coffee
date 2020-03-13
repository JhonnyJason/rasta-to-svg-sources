vanillautilmodule = {name: "vanillautilmodule"}

#region modulesFromTheEnvironment
#endregion

#region easingsDefinition
easings = 
    linear: (t) ->
        t
    easeInQuad: (t) ->
        t * t
    easeOutQuad: (t) ->
        t * (2 - t)
    easeInOutQuad: (t) ->
        if t < 0.5 then 2 * t * t else -1 + (4 - (2 * t)) * t
    easeInCubic: (t) ->
        t * t * t
    easeOutCubic: (t) ->
        --t * t * t + 1
    easeInOutCubic: (t) ->
        if t < 0.5 then 4 * t * t * t else (t - 1) * (2 * t - 2) * (2 * t - 2) + 1
    easeInQuart: (t) ->
        t * t * t * t
    easeOutQuart: (t) ->
        1 - (--t * t * t * t)
    easeInOutQuart: (t) ->
        if t < 0.5 then 8 * t * t * t * t else 1 - (8 * --t * t * t * t)
    easeInQuint: (t) ->
        t * t * t * t * t
    easeOutQuint: (t) ->
        1 + --t * t * t * t * t
    easeInOutQuint: (t) ->
        if t < 0.5 then 16 * t * t * t * t * t else 1 + 16 * --t * t * t * t * t
#endregion

#region printLogFunctions
##############################################################################
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["vanillautilmodule"]?  then console.log "[vanillautilmodule]: " + arg
    return
print = (arg) -> console.log(arg)
#endregion
##############################################################################
vanillautilmodule.initialize = () ->
    log "vanillautilmodule.initialize"
    return
    
#region internalFunctions
alertScrollend = -> alert("Scoll ended!")
#endregion

#region exposedFunctions
vanillautilmodule.scrollTo = (destination, duration = 400, easing = 'easeInOutQuad', callback) ->
    
    start = window.pageYOffset
    startTime = if 'now' of window.performance then performance.now() else (new Date).getTime()
    
    getScrollOffset = ->
        destinationOffset = if typeof destination == 'number' then destination else destination.offsetTop
        documentHeight = Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight)
        windowHeight = window.innerHeight or document.documentElement.clientHeight or document.getElementsByTagName('body')[0].clientHeight
        return Math.round(if documentHeight - destinationOffset < windowHeight then documentHeight - windowHeight else destinationOffset)

    scroll = ->
        scrollOffset = getScrollOffset()
        now = if 'now' of window.performance then performance.now() else (new Date).getTime()
        time = Math.min(1, (now - startTime) / duration)
        timeFunction = easings[easing](time)
        window.scroll 0, Math.ceil(timeFunction * (scrollOffset - start) + start)

        if now >= (startTime + duration)
            if callback then callback()
            return
        requestAnimationFrame scroll
        return
  
    scroll()
    return
#endregion

module.exports = vanillautilmodule