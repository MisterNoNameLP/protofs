print("init")

_G.global = {}
local fse, renderer, main

--debug stuff
_G.protofs = {}
_G.protofs.debugInfo = {}
_G.protofs.debugInfo.cellCount = 0

--init
print(loadfile("data/engine/classes/Vector.lua"))
global.Vector = loadfile("data/engine/classes/Vector.lua")()

print(loadfile("data/engine/fse.lua"))
fse = loadfile("data/engine/fse.lua")()
fse.init(10, 10)
global.fse = fse

print(loadfile("data/engine/renderer.lua"))
renderer = loadfile("data/engine/renderer.lua")()
renderer.init()
global.renderer = renderer

print(loadfile("data/engine/main.lua"))
main = loadfile("data/engine/main.lua")()
main.init(fse, renderer)
global.main = main

print("init done")