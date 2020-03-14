debugmodule = {name: "debugmodule", uimodule: false}

#####################################################
debugmodule.initialize = () ->
    # console.log "debugmodule.initialize - nothing to do"
    return

debugmodule.modulesToDebug = 
    unbreaker: true
    # configmodule: true
    # headermodule: true
    imageselectmodule: true
    # layoutmanagermodule: true
    # menumodule: true
    # outputfiltermodule: true
    # outputimagemodule: true
    # sourcefiltermodule: true
    sourceimagemodule: true
    # transformmodule:true

export default debugmodule
