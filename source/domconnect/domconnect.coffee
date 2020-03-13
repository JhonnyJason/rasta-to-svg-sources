domconnect = {name: "domconnect"}

############################################################
domconnect.initialize = () ->
    global.footer = document.getElementById("footer")
    global.menu = document.getElementById("menu")
    global.imageIcon = document.getElementById("image-icon")
    global.camIcon = document.getElementById("cam-icon")
    global.svgicons = document.getElementById("svgicons")
    console.log("-> used Elements available in their global variable!")
    return
    
module.exports = domconnect