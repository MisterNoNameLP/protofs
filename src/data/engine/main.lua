local main = {}
local love = love

global.tick = 0

function main.init()

	for c = 1, 10 do
		global.fse.matrices[1].matrix[c][1]:setPressure(c * .1)
		global.fse.matrices[2].matrix[c][1]:setPressure(c * .1)
	end
	
end

function love.update(dt)
	global.justInitialized = false
	global.tick = global.tick + 1
	
	if global.tick % 2 == 0 then
		--print("Tick:", global.tick)
	else
		--print("Tock:", global.tick)
	end
	
	
	
	global.fse.update(dt)
	global.game.update(dt)
	global.bladi.update(dt)
end

function love.draw()
	if global.justInitialized then
		return 
	end
	
	global.renderer.preDraw()
	global.fse.draw(-50, -50, global.conf.squareScale, global.conf.squareGab)
	global.renderer.afterDraw()
	global.game.draw()
	global.bladi.draw()
end

return main