local core = {}
local love = love

local gotError = false
local frame = 0

local fse, renderer, game

function core.init(orgFSE, orgRenderer, orgGame, orgUiHandler)
	fse, renderer, game, uiHandler = orgFSE, orgRenderer, orgGame, orgUiHandler
end

function love.keypressed(key)
	if key == "r" then
		loadfile("data/init.lua")()
	end
end

function love.update(dt)
	frame = frame + 1
	if gotError then
		print("Frame: " .. tostring(frame))
		print("Reloaded: " .. tostring(_G.reloaded))
		_G.reloaded = _G.reloaded + 1
		love.timer.sleep(1)
		gotError = false

		loadfile("data/init.lua")()
	end

	local suc, err = xpcall(function(dt) 
		uiHandler.update(dt)
		game.update(dt)
		fse.update(dt)
	end, debug.traceback, dt)

	if suc ~= true then
		print("=== UPDATE ERROR ===")
		print(suc, err)
		gotError = true
	end

end

function love.draw()
	local suc, err = xpcall(function(dt) 
		renderer.preDraw()
		uiHandler.draw()
		game.draw()
		renderer.afterDraw()
	end, debug.traceback, dt)

	if suc ~= true then
		print("=== DRAW ERROR ===")
		print(suc, err)
		gotError = true
	end
end

return core