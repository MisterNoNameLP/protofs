local game = {}

function game.init(dt)
	
end

function game.update(dt)
	
	if input.keyPressed("r") then
		loadfile("data/init.lua")()
		isResetting = true
	end
	
	global.fse.getCurrentCell(3, 3):setPressure(.01)
	--print(global.fse.getCurrentCell(3, 5):getPressure())
	
end

function game.draw(dt)
	
end

return game