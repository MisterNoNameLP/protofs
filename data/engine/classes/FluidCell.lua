local FluidCell = {}

function FluidCell.new(x, y)
	local self = setmetatable({}, {__index = FluidCell})

	_G.protofs.debugInfo.cellCount = _G.protofs.debugInfo.cellCount +1
	self.id = _G.protofs.debugInfo.cellCount
	self.color = {0, .3, .6}
	
	self.x = x
	self.y = y
	
	self.pressure = 0
	self.mass = 0
	self.velocity = global.Vector.new()
	self.lastForceTimestamp = love.timer.getTime()
	

	return self
end

function FluidCell:update(dt, matrix)
	--print("fluidCell" .. tostring(self.id) .. ": update")
	
	self.mass = self.pressure
	--global.fse.fluidMatrix.matrix[self.x][self.y - 1]:setPressure()
	
end

function FluidCell:draw(posX, posY, offsetX, offsetY, scale, gab)
	--print("fluidCell" .. tostring(self.id) .. ": draw")

	local renderPosX = posX * scale + gab * posX + offsetX
	local renderPosY = posY * scale + gab * posY + offsetY

	self.color[4] = self.pressure * 2 --alpha

	love.graphics.setColor(self.color)
	love.graphics.rectangle("fill", 
		renderPosX, 
		renderPosY,
		scale, 
		scale
	)
end

function FluidCell:getPressure(value)
	return self.pressure
end
function FluidCell:setPressure(value)
	self.pressure = value
end

function FluidCell:setVelocity(newVelocity)
	self.velocity = newVelocity
end

function FluidCell:addForce(force)
	global.fse.fluidMatrix.matrix[10][self.y]:setPressure(1 / (2 ^ (10 - self.x)))
	self.pressure = 0
	
	self.lastForceTimestamp = love.timer.getTime()
end


return FluidCell