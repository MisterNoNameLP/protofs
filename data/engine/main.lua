local main = {}
local love = love
local fse, renderer

local matrix

local isResetting = true

global.tick = 0

function main.init(orgFSE, orgRenderer)
	fse, renderer = orgFSE, orgRenderer
	
	fse.matrix[1].matrix[5][1]:setPressure(1)
	fse.matrix[2].matrix[5][1]:setPressure(1)
	
	
end

function love.update(dt)
	if global.tick % 2 == 0 then
		print("Tick:", global.tick)
	else
		print("Tock:", global.tick)
	end
	
	global.tick = global.tick + 1
	
	if love.keyboard.isDown("r") and not isResetting then
		loadfile("data/init.lua")()
		isResetting = true
	end
	if not love.keyboard.isDown("r") then
		isResetting = false
	end
	
	if love.keyboard.isDown("t") then
		matrix[5][1]:addForce()
		
	end
	
	fse.update(dt)
	
	print(fse.matrix[1].matrix[5][8]:getPressure())
	print(fse.matrix[2].matrix[5][8]:getPressure())
	
end

function love.draw()
	renderer.preDraw()
	fse.draw(-50, -50, 75, 3)
	renderer.afterDraw()
end

return main