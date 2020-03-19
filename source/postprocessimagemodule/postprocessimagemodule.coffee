postprocessimagemodule = {name: "postprocessimagemodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["postprocessimagemodule"]?  then console.log "[postprocessimagemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
width = 300
height = 300

pixelsWithObjects = new Array(width*height)
checkedPixels = new Array(width*height)

processChannel = null

minVolume = 100

foundObjects = []

currentObject = null
pixelsToCheck = []

############################################################
postprocessimagemodule.initialize = () ->
    log "postprocessimagemodule.initialize"
    return

drawBestGuess = ->
    log "drawBestGuess"
    removeDrawnElements()
    for element in foundObjects
        drawBestGuessForObject(element)
    return

removeDrawnElements = ->
    log "removeDrawnElements"
    while postprocessimageResultSvg.firstChild
        postprocessimageResultSvg.removeChild postprocessimageResultSvg.lastChild
    return

drawBestGuessForObject = (foundObject) ->
    log "drawBestGuessForObject"
    rect = document.createElementNS("http://www.w3.org/2000/svg", "rect")
    rect.setAttribute("x", foundObject.minX);
    rect.setAttribute("y", foundObject.minY);
    rect.setAttribute("width", foundObject.maxX - foundObject.minX);
    rect.setAttribute("height", foundObject.maxY - foundObject.minY);
    postprocessimageResultSvg.appendChild(rect)
    return

############################################################
#region objectFinding
findConnectedObjects = ->
    log "findConnectedObjects"
    foundObjects.length = 0
    pixelsWithObjects.fill(false)
    checkedPixels.fill(false)
    return unless processChannel

    for value,index in processChannel
        if value and !pixelsWithObjects[index]
            findNewObject(index)
        checkedPixels[index] = true

    removeSmallObjects()
    return

############################################################
removeSmallObjects = ->
    log "removeSmallObjects"
    goodObjects = []
    for element in foundObjects
        goodObjects.push(element) if element.volume >= minVolume
    foundObjects = goodObjects
    return

############################################################
addPixelToCurrentObject = (pixel) ->
    currentObject.volume++
    pixelsWithObjects[pixel] = true
    x = pixel % width
    y = Math.floor(pixel / width)
    if x < currentObject.minX then currentObject.minX = x
    if x > currentObject.maxX then currentObject.maxX = x
    if y < currentObject.minY then currentObject.minY = y
    if y > currentObject.maxY then currentObject.maxY = y    
    return

############################################################
findNewObject = (index) ->
    log "findNewObject"
    pixelsToCheck.length = 0

    currentObject = 
        volume: 0
        minX: width
        maxX: 0
        minY: height
        maxY: 0

    checkPixel(index)
    while pixelsToCheck.length
        pixel = pixelsToCheck.pop()
        if !pixelsWithObjects[pixel] and processChannel[pixel]
            addPixelToCurrentObject(pixel)
            checkNeighbourPixels(pixel)

    foundObjects.push currentObject
    return

############################################################
checkNeighbourPixels = (index) ->
    getSideNeighbours(index)
    prevRowPixel = index-width
    postRowPixel = index+width
    if prevRowPixel > 0 
        checkPixel(prevRowPixel)
        getSideNeighbours(prevRowPixel)
    if postRowPixel < (width * height)
        checkPixel(postRowPixel)
        getSideNeighbours(postRowPixel)
    return

getSideNeighbours = (index) ->
    columnIndex = index % width
    rowIndex = Math.floor(index / width)  
    if columnIndex > 0 then checkPixel(index-1)
    if columnIndex < (width-1) then checkPixel(index+1)
    return

checkPixel = (index) ->
    return if checkedPixels[index]
    pixelsToCheck.push(index)
    checkedPixels[index] = true
    return

#endregion

############################################################
postprocessimagemodule.setBackground = (dataURL) ->
    log "postprocessimagemodule.setBackground"
    postprocessimageBackground.src = dataURL
    return

postprocessimagemodule.setChannelToProcess = (channel) ->
    log "postprocessimagemodule.setChannelToProcess"
    processChannel = channel
    return

postprocessimagemodule.act = ->
    log "postprocessimagemodule.act"
    findConnectedObjects()
    olog foundObjects
    drawBestGuess()
    return

module.exports = postprocessimagemodule