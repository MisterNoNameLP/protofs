print("init")

local fse, renderer, core, game, uiHandler

--debug stuff
_G.protofs = {}
_G.protofs.debugInfo = {}
_G.protofs.debugInfo.cellCount = 0

--local functions
local function load(path)
	local func, err = loadfile(path)

	while true do
		if func == nil then
			print("Cant load func: " .. path)
			print(err)
			love.timer.sleep(1)
			func, err = loadfile(path)
		else
			return func
		end
	end
end

--init
load("data/engine/conf.lua")()

fse = load("data/engine/fse.lua")()
fse.init(10, 10)

renderer = load("data/engine/renderer.lua")()
renderer.init()

load("data/engine/Vector.lua")()

uiHandler = load("data/game/uiHandler.lua")()
uiHandler.init()

game = load("data/game/game.lua")()
game.init(fse, renderer)

core = load("data/engine/core.lua")()
core.init(fse, renderer, game, uiHandler)
