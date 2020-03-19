indexdomconnect = {name: "indexdomconnect"}

############################################################
indexdomconnect.initialize = () ->
    global.postprocessimageBackground = document.getElementById("postprocessimage-background")
    global.postprocessimageResultSvg = document.getElementById("postprocessimage-result-svg")
    global.postprocessControl = document.getElementById("postprocess-control")
    global.outputimageCanvas = document.getElementById("outputimage-canvas")
    global.outputfilterControl = document.getElementById("outputfilter-control")
    global.scaleValuesInput = document.getElementById("scale-values-input")
    global.binarizeThresholdInput = document.getElementById("binarize-threshold-input")
    global.outputfilterResetButton = document.getElementById("outputfilter-reset-button")
    global.sourceimageCanvas = document.getElementById("sourceimage-canvas")
    global.hiddenSourceImage = document.getElementById("hidden-source-image")
    global.hiddenSourceVideo = document.getElementById("hidden-source-video")
    global.sourcefilterControl = document.getElementById("sourcefilter-control")
    global.blurInput = document.getElementById("blur-input")
    global.contrastInput = document.getElementById("contrast-input")
    global.saturateInput = document.getElementById("saturate-input")
    global.grayscaleInput = document.getElementById("grayscale-input")
    global.invertInput = document.getElementById("invert-input")
    global.sourcefilterResetButton = document.getElementById("sourcefilter-reset-button")
    global.imageselectArea = document.getElementById("imageselect-area")
    global.imageselectInput = document.getElementById("imageselect-input")
    global.captureButton = document.getElementById("capture-button")
    global.resumeButton = document.getElementById("resume-button")
    global.viewAllButton = document.getElementById("view-all-button")
    global.imageSelectButton = document.getElementById("image-select-button")
    global.camImageButton = document.getElementById("cam-image-button")
    global.toggleSourceFilterButton = document.getElementById("toggle-source-filter-button")
    global.outputImageButton = document.getElementById("output-image-button")
    global.toggleOutputFilterButton = document.getElementById("toggle-output-filter-button")
    global.postProcessButton = document.getElementById("post-process-button")
    global.toggleProcessSettingsButton = document.getElementById("toggle-process-settings-button")
    console.log("-> used Elements available in their global variable!")
    return
    
module.exports = indexdomconnect