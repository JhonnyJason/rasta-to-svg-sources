import Modules from "./allmodules"
import domconnect from "./domconnect"

global.allModules = Modules


window.onload = ->
    domconnect.initialize()
    promises = (m.initialize() for n,m of Modules)
    await Promise.all(promises)
    appStartup()
    return


appStartup = ->
    ## which modules shall be kickstarted?
    Modules.transformmodule.act()
    return
