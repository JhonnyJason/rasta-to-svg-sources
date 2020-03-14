menumodule = {name: "menumodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["menumodule"]?  then console.log "[menumodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
#region localModules
source = null
output = null
post = null
sourcefilter = null
outputfilter = null
postprocess = null
layoutmanager = null
#endregion

############################################################
menumodule.initialize = () ->
    log "menumodule.initialize"
    source = allModules.sourceimagemodule
    output = allModules.outputimagemodule
    post = allModules.postprocessimagemodule
    sourcefilter = allModules.sourcefiltermodule
    outputfilter = allModules.outputfiltermodule
    postprocess = allModules.postprocessmodule
    layoutmanager = allModules.layoutmanagermodule

    #region addingEventListeners
    viewAllButton.addEventListener("click", vieAllButtonClicked)
    
    imageSelectButton.addEventListener("click", imageSelectButtonClicked)
    camImageButton.addEventListener("click", camImageButtonClicked)
    toggleSourceFilterButton.addEventListener("click", toggleSourceFilterButtonClicked)

    outputImageButton.addEventListener("click", outputImageButtonClicked)
    toggleOutputFilterButton.addEventListener("click", toggleOutputFilterButtonClicked)

    postProcessButton.addEventListener("click", postProcessButtonClicked)
    toggleProcessSettingsButton.addEventListener("click", toggleProcessSettingsButtonClicked)
    #endregion
    return
    
############################################################
#region internalFunctions
setActiveSource = (label) ->
    log "setActiveSource"
    if label == "image"
        imageSelectButton.className = "active"
        camImageButton.className = ""
        return
    if label == "cam"
        camImageButton.className = "active"
        imageSelectButton.className = ""
        return
    return

############################################################
#region eventHandlers
vieAllButtonClicked = ->
    log "vieAllButtonClicked"
    layoutmanager.viewAll()
    return

############################################################
imageSelectButtonClicked = ->
    log "imageSelectButtonClicked"
    activeSource = await source.setSource("image")
    setActiveSource(activeSource)
    layoutmanager.viewSource()
    return

camImageButtonClicked = ->
    log "camImageButtonClicked"
    activeSource = await source.setSource("cam")
    setActiveSource(activeSource)
    layoutmanager.viewSource()
    return

toggleSourceFilterButtonClicked = ->
    log "filterSettingsIconClicked"
    isHidden = sourcefilter.toggleHidden()
    if isHidden
        toggleSourceFilterButton.classList.remove("active")
    else
        toggleSourceFilterButton.classList.add("active")
    return

############################################################
outputImageButtonClicked = ->
    log "outputImageButtonClicked"
    layoutmanager.viewOutput()
    return

toggleOutputFilterButtonClicked = ->
    log "toggleOutputFilterButtonClicked"
    isHidden = outputfilter.toggleHidden()
    if isHidden
        toggleOutputFilterButton.classList.remove("active")
    else
        toggleOutputFilterButton.classList.add("active")
    return

############################################################
postProcessButtonClicked = ->
    log "postProcessButtonClicked"
    layoutmanager.viewPostProcess()
    return

toggleProcessSettingsButtonClicked = ->
    log "toggleProcessSettingsButtonClicked"
    isHidden = postprocess.toggleHiddenControls()
    if isHidden
        toggleProcessSettingsButton.classList.remove("active")
    else
        toggleProcessSettingsButton.classList.add("active")
    return

#endregion

#endregion

############################################################
menumodule.setViewAllButtonActive = (activeness) ->
    log "menumodule.setViewAllButtonActive"
    if activeness ==  true
        viewAllButton.className = "active"
        return
    if activeness == false
        viewAllButton.className = ""
        return
    return

module.exports = menumodule