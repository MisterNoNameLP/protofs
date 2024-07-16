local game = {}
local love = love
local fse, renderer

local matrix

local isResetting = true

function game.init(orgFSE, orgRenderer)
	fse, renderer = orgFSE, orgRenderer
	matrix = fse.fluidMatrix.matrix
	
	matrix[5][2]:setPressure(1)
	
	
end

function love.update(dt)
	if love.keyboard.isDown("r") and not isResetting then
		loadfile("data/init.lua")()
		isResetting = true
	end
	if not love.keyboard.isDown("r") then
		isResetting = false
	end
	
	if love.keyboard.isDown("t") then
		matrix[5][1]:addForce()
		
		fse.update(dt)		
	end
	
	print("Hello Bladiiiiiii222222")
	
end

function love.draw()
	renderer.preDraw()
	fse.draw(-50, -50, 75, 3)
	renderer.afterDraw()
end

return game