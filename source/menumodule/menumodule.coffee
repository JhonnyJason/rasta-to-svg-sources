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
state = null
source = null
output = null
post = null
sourcefilter = null
outputfilter = null
postprocess = null
layoutmanager = null
#endregion

############################################################
menuState = 
    imageSelectActive: true

############################################################
menumodule.initialize = () ->
    log "menumodule.initialize"
    state = allModules.uistatemodule
    source = allModules.sourceimagemodule
    output = allModules.outputimagemodule
    post = allModules.postprocessimagemodule
    sourcefilter = allModules.sourcefiltermodule
    outputfilter = allModules.outputfiltermodule
    postprocess = allModules.postprocesssettingsmodule
    layoutmanager = allModules.layoutmanagermodule

    savedState = state.getState().menuState
    if savedState then menuState = savedState

    applyState()

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
applyState = ->
    log "applyState"

    olog menuState
    ############################################################
    if menuState.viewAllActive
        viewAllButton.classList.add "active"
    else 
        viewAllButton.classList.remove "active"
    
    ############################################################
    if menuState.imageSelectActive
        imageSelectButton.classList.add "active"
    else 
        imageSelectButton.classList.remove "active"
    
    if menuState.camImageActive
        camImageButton.classList.add "active"
    else 
        camImageButton.classList.remove "active"

    if menuState.sourceFilterActive
        toggleSourceFilterButton.classList.add "active"
    else
        toggleSourceFilterButton.classList.remove "active"

    ############################################################
    if menuState.outputImageActive
        outputImageButton.classList.add "active"
    else 
        outputImageButton.classList.remove "active"
    
    if menuState.outputFilterActive
        toggleOutputFilterButton.classList.add "active"
    else
        toggleOutputFilterButton.classList.remove "active"
    
    ############################################################
    if menuState.postProcessActive
        postProcessButton.classList.add "active"
    else
        postProcessButton.classList.remove "active"

    if menuState.processSettingsActive
        toggleProcessSettingsButton.classList.add "active"
    else
        toggleProcessSettingsButton.classList.remove "active"

    return

saveState = ->
    log "saveState"
    state.saveMenuState(menuState)
    return

############################################################
#region UIStateSetter
setActiveSource = (label) ->
    log "setActiveSource"
    if label == "image"
        menuState.imageSelectActive = true
        menuState.camImageActive = false
    if label == "cam"
        menuState.camImageActive = true
        menuState.imageSelectActive = false

    menuState.outputImageActive = false
    menuState.postProcessActive = false
    
    applyState()
    saveState()
    return

setActiveOutput = ->
    log "setActiveOutput"
    menuState.outputImageActive = true
    menuState.imageSelectActive = false
    menuState.camImageActive = false
    menuState.postProcessActive = false
    applyState()
    saveState()
    return

setActivePostprocess = ->
    log "setActivePostprocess"
    menuState.postProcessActive = true
    menuState.imageSelectActive = false
    menuState.camImageActive = false
    menuState.outputImageActive = false
    applyState()
    saveState()
    return

setSourceFilterActiveness = (activeness) ->
    log "setSourceFilterActiveness"
    menuState.sourceFilterActive = activeness
    applyState()
    saveState()
    return

setOutputFilterActiveness = (activeness) ->
    log "setOutputFilterActiveness"
    menuState.outputFilterActive = activeness
    applyState()
    saveState()
    return

setProcessSettingsActiveness = (activeness) ->
    log "setProcessSettingsActiveness"
    menuState.processSettingsActive = activeness
    applyState()
    saveState()
    return

#endregion

############################################################
#region eventHandlers
vieAllButtonClicked = ->
    log "vieAllButtonClicked"
    layoutmanager.viewAll()
    return

############################################################
imageSelectButtonClicked = ->
    log "imageSelectButtonClicked"
    activeSource = await source.setSource "image"
    setActiveSource activeSource
    layoutmanager.viewSource()
    return

camImageButtonClicked = ->
    log "camImageButtonClicked"
    activeSource = await source.setSource "cam"
    setActiveSource activeSource
    layoutmanager.viewSource()
    return

toggleSourceFilterButtonClicked = ->
    log "filterSettingsIconClicked"
    isHidden = sourcefilter.toggleHidden()
    if isHidden then setSourceFilterActiveness false
    else setSourceFilterActiveness true
    return

############################################################
outputImageButtonClicked = ->
    log "outputImageButtonClicked"
    setActiveOutput()
    layoutmanager.viewOutput()
    return

toggleOutputFilterButtonClicked = ->
    log "toggleOutputFilterButtonClicked"
    isHidden = outputfilter.toggleHidden()
    if isHidden then setOutputFilterActiveness false
    else setOutputFilterActiveness true
    return

############################################################
postProcessButtonClicked = ->
    log "postProcessButtonClicked"
    setActivePostprocess()
    layoutmanager.viewPostProcess()
    return

toggleProcessSettingsButtonClicked = ->
    log "toggleProcessSettingsButtonClicked"
    isHidden = postprocess.toggleHiddenControls()
    if isHidden then setProcessSettingsActiveness false
    else setProcessSettingsActiveness true
    return

#endregion

#endregion

############################################################
menumodule.setViewAllButtonActive = (activeness) ->
    log "menumodule.setViewAllButtonActive"
    menuState.viewAllActive = activeness
    applyState()
    savedState()
    return

module.exports = menumodule