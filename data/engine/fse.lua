local fse = {
	currentMatrix = 1,
	currentMatrixRender = 2,
	
	nextMatrix = 2,
	
	matrix = {},
}

function fse.init(sizeX, sizeY)
	fse.matrix = {
		loadfile("data/engine/classes/FluidMatrix.lua")().new(
			sizeX, sizeY, global.loadfile("data/engine/classes/FluidCell.lua")()
		),
		loadfile("data/engine/classes/FluidMatrix.lua")().new(
			sizeX, sizeY, global.loadfile("data/engine/classes/FluidCell.lua")()
		)
	}
end

function fse.update(dt)	
	fse.matrix[fse.currentMatrix]:update(dt)
	
	if fse.currentMatrix + 1 > #fse.matrix then
		fse.currentMatrix = 1
	else
		fse.currentMatrix = fse.currentMatrix + 1
	end
	if fse.currentMatrix + 1 > #fse.matrix then
		fse.nextMatrix = 1
	else
		fse.nextMatrix = fse.currentMatrix + 1
	end
	
end

function fse.draw(offsetX, offsetY, scale, gab)
	fse.matrix[fse.currentMatrixRender]:draw(offsetX, offsetY, scale, gab)
	
	if fse.currentMatrixRender + 1 > #fse.matrix then
		fse.currentMatrixRender = 1
	else
		fse.currentMatrixRender = fse.currentMatrixRender + 1
	end
end

function fse.getCurrentMatrix()
	return fse.matrix[fse.currentMatrix]
end
function fse.getNextMatrix()
	return fse.matrix[fse.nextMatrix]
end
function fse.getCurrentCell(x, y)
	return fse.getCurrentMatrix()[x][y]
end
function fse.getNextCell(x, y)
	return fse.getNextMatrix()[x][y]
end

return fse