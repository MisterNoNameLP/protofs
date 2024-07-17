local main = {}
local love = love
local fse, renderer

global.tick = 0

function main.init(orgFSE, orgRenderer)
	fse, renderer = orgFSE, orgRenderer
	
	for c = 1, 10 do
		fse.matrix[1].matrix[c][1]:setPressure(c * .1)
		fse.matrix[2].matrix[c][1]:setPressure(c * .1)
	end
	
end

function love.update(dt)
	global.tick = global.tick + 1
	
	if global.tick % 2 == 0 then
		--print("Tick:", global.tick)
	else
		--print("Tock:", global.tick)
	end
	
	if input.keyPressed("r") then
		loadfile("data/init.lua")()
		isResetting = true
	end
	
	
	
	fse.update(dt)

	
end

function love.draw()
	renderer.preDraw()
	fse.draw(-50, -50, global.conf.squareScale, global.conf.squareGab)
	renderer.afterDraw()
end

return main