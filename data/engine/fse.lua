local fse = {
	
}

function fse.init(sizeX, sizeY)
	print(loadfile("data/engine/classes/FluidCell.lua"))
	fse.fluidMatrix = loadfile("data/engine/classes/FluidMatrix.lua")().new(
		sizeX, sizeY, loadfile("data/engine/classes/FluidCell.lua")()
	)
end

function fse.update(dt)
	fse.fluidMatrix:update(dt)
end

function fse.draw(offsetX, offsetY, scale, gab)
	fse.fluidMatrix:draw(offsetX, offsetY, scale, gab)
end

return fse