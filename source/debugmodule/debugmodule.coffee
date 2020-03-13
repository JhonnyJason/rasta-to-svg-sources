debugmodule = {name: "debugmodule", uimodule: false}

#####################################################
debugmodule.initialize = () ->
    # console.log "debugmodule.initialize - nothing to do"
    return

debugmodule.modulesToDebug = 
    unbreaker: true
    # configmodule: true
    # headermodule: true
    filtersettingsmodule: true
    sourceimagemodule: true
    outputimagemodule: true
    transformmodule:true

export default debugmodule
