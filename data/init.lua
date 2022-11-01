print("init")

local fse, renderer, game

--debug stuff
_G.protofs = {}
_G.protofs.debugInfo = {}
_G.protofs.debugInfo.cellCount = 0

--init
fse = loadfile("data/engine/fse.lua")()
fse.init(10, 10)

renderer = loadfile("data/engine/renderer.lua")()
renderer.init()

game = loadfile("data/game/game.lua")()
game.init(fse, renderer)

