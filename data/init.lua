print("init")

_G.global = {}
local fse, renderer, game

--debug stuff
_G.protofs = {}
_G.protofs.debugInfo = {}
_G.protofs.debugInfo.cellCount = 0

--init
global.Vector = loadfile("data/engine/classes/Vector.lua")()

fse = loadfile("data/engine/fse.lua")()
fse.init(10, 10)
global.fse = fse

renderer = loadfile("data/engine/renderer.lua")()
renderer.init()
global.renderer = renderer

game = loadfile("data/game/game.lua")()
game.init(fse, renderer)
global.game = game

