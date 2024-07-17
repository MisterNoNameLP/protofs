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
	
	if self.y < 10 and self:getPressure() > 0 then
		local otherCell = global.fse.matrix[global.fse.nextMatrix].matrix[self.x][self.y + 1]
		local flowRate = .0
		
		otherCell:setPressure(otherCell:getPressure() + math.min(self:getPressure(), flowRate))
		self:setPressure(math.max(self:getPressure() - flowRate, 0))
	end
	
	if self.y == 11 then
		local leftCell
		local rightCell
		
		if global.fse.matrix[global.fse.nextMatrix].matrix[self.x - 1] ~= nil then
			leftCell = global.fse.matrix[global.fse.nextMatrix].matrix[self.x - 1][self.y]
		end
		if global.fse.matrix[global.fse.nextMatrix].matrix[self.x + 1] ~= nil then
			rightCell = global.fse.matrix[global.fse.nextMatrix].matrix[self.x + 1][self.y]
		end
		
		if leftCell ~= nil and self:getPressure() > leftCell:getPressure() then
			local diff = self:getPressure() - leftCell:getPressure()
			leftCell:setPressure(leftCell:getPressure() + diff / 2)
			self:setPressure(self:getPressure() - diff / 2)
		end
		if rightCell ~= nil and self:getPressure() > rightCell:getPressure() then
			local diff = self:getPressure() - rightCell:getPressure()
			rightCell:setPressure(rightCell:getPressure() + diff / 2)
			self:setPressure(self:getPressure() - diff / 2)
		end
			
	end
	
end

function FluidCell:draw(posX, posY, offsetX, offsetY, scale, gab)
	local renderPosX = posX * scale + gab * posX + offsetX
	local renderPosY = posY * scale + gab * posY + offsetY
	
	do --pressure overlay
		local colorMult = math.max(global.conf.pressureOverlayColorMult, global.conf.pressureOverlayColorMult)
		if self:getPressure() == 0 then
			self.color = {1, 1, 1, 0}
		elseif self:getPressure() <= 0.5 / colorMult then
			self.color = {self:getPressure() * 2 * colorMult, 1, 0}
		else
			self.color = {1, 2 - (self:getPressure() * 2 - .1 / colorMult) * colorMult, 0}
		end
	end
		
	
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