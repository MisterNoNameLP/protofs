print("init")

print(loadfile("data/global.lua"))
_G.global = loadfile("data/global.lua")()

print(global.loadfile)

local loadfile = global.loadfile
local fse, renderer, main

--debug stuff
_G.protofs = {}
_G.protofs.debugInfo = {}
_G.protofs.debugInfo.cellCount = 0

--init

global.ut = loadfile("data/libs/UT.lua")()
global.conf = loadfile("data/gameConf.lua")()
global.input = loadfile("data/engine/input.lua")()
_G.input = global.input
global.Vector = loadfile("data/engine/classes/Vector.lua")()

fse = loadfile("data/engine/fse.lua")()
fse.init(10, 10)
global.fse = fse

renderer = loadfile("data/engine/renderer.lua")()
renderer.init()
global.renderer = renderer

main = loadfile("data/engine/main.lua")()
main.init(fse, renderer)
global.main = main

print("init done")