filtersettingsmodule = {name: "filtersettingsmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["filtersettingsmodule"]?  then console.log "[filtersettingsmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
transform = null

############################################################
#region HTMLElements
filtersettings = null
blurInput = null
contrastInput = null
saturateInput = null
grayscaleInput = null
invertInput = null
resetButton = null
#endregion

############################################################
defaultContextConfig = 
    blur: "1"
    contrast: "250"
    saturate: "200"
    grayscale: true
    invert: true
contextConfigObject = Object.assign({}, defaultContextConfig)

############################################################
filtersettingsmodule.initialize = () ->
    log "filtersettingsmodule.initialize"
    transform = allModules.transformmodule

    filtersettings = document.getElementById("filtersettings")
    blurInput = document.getElementById("blur-input")
    contrastInput = document.getElementById("contrast-input")
    saturateInput = document.getElementById("saturate-input")
    grayscaleInput = document.getElementById("grayscale-input")
    invertInput = document.getElementById("invert-input")
    resetButton = document.getElementById("reset-button")

    # blurInput.addEventListener("change", blurInputChanged)
    # contrastInput.addEventListener("change", contrastInputChanged)
    # saturateInput.addEventListener("change", saturateInputChanged)
    # grayscaleInput.addEventListener("change", grayscaleInputChanged)
    # invertInput.addEventListener("change", invertInputChanged)
    # resetButton.addEventListener("click", resetButtonClicked)

    # assignCurrentValues()
    # transform.adjustContextFilter(contextConfigObject)
    return

############################################################
resetValues = ->
    log "resetValues"
    contextConfigObject = Object.assign({}, defaultContextConfig)
    assignCurrentValues()
    propagateValues()
    return

assignCurrentValues = ->
    log "assignCurrentValues"
    blurInput.value = contextConfigObject.blur
    contrastInput.value = contextConfigObject.contrast
    saturateInput.value = contextConfigObject.saturate
    grayscaleInput.checked = contextConfigObject.grayscale
    invertInput.checked = contextConfigObject.invert
    return

propagateValues = ->
    log "propagateValues"
    transform.adjustContextFilter(contextConfigObject)
    transform.act()
    return

############################################################
#region eventListeners
blurInputChanged = ->
    log "blurInputChanged"
    value = blurInput.value
    contextConfigObject.blur = value
    propagateValues()
    return

contrastInputChanged = ->
    log "contrastInputChanged"
    value = contrastInput.value
    contextConfigObject.contrast = value
    propagateValues()
    return

saturateInputChanged = ->
    log "saturateInputChanged"
    value = saturateInput.value
    contextConfigObject.saturate = value
    propagateValues()
    return

grayscaleInputChanged = ->
    log "grayscaleInputChanged"
    value = grayscaleInput.checked
    contextConfigObject.grayscale = value
    propagateValues()
    return

invertInputChanged = ->
    log "invertInputChanged"
    value = invertInput.checked
    contextConfigObject.invert = value
    propagateValues()
    return

resetButtonClicked = ->
    log "resetButtonClicked"
    resetValues()
    return
#endregion

############################################################
filtersettingsmodule.setActive = (activeness) ->
    log "filtersettingsmodule.setActive"
    if activeness then filtersettings.classList.remove("hidden")
    else filtersettings.classList.add("hidden")
    return

module.exports = filtersettingsmodule