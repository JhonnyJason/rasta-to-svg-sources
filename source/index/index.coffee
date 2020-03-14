import Modules from "./allmodules"
import domconnect from "./indexdomconnect"

global.allModules = Modules

window.onload = ->
    domconnect.initialize()
    promises = (m.initialize() for n,m of Modules)
    await Promise.all(promises)
    appStartup()
    return

appStartup = ->
    Modules.layoutmanagermodule.checkPossibleLayout()
    Modules.transformmodule.act()
    return
