print("init")

print(loadfile("data/global.lua"))
_G.global = loadfile("data/global.lua")()

local loadFile = global.loadFile
local fse, renderer, main

--debug stuff
_G.protofs = {}
_G.protofs.debugInfo = {}
_G.protofs.debugInfo.cellCount = 0

--init

global.conf = loadFile("data/gameConf.lua")()

global.Vector = loadFile("data/engine/classes/Vector.lua")()

fse = loadFile("data/engine/fse.lua")()
fse.init(10, 10)
global.fse = fse

renderer = loadFile("data/engine/renderer.lua")()
renderer.init()
global.renderer = renderer

main = loadFile("data/engine/main.lua")()
main.init(fse, renderer)
global.main = main

print("init done")