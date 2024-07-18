local game = {}

debug.setFuncPrefix("[GAME]", nil, nil, 1)

function game.init(dt)
	--debug.setFuncPrefix("[INIT]")
	--debug.log("TEST")
end

function game.update(dt)
	
	if input.keyPressed("r") then
		loadfile("data/init.lua")()
		isResetting = true
	end
	
	--global.fse.getCurrentCell(3, 3):setPressure(.01)
	--print(global.fse.getCurrentCell(3, 5):getPressure())
	
	
	
	--debug.log("game")
end

function game.draw(dt)
	
end

return game