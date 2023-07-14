local Vector = {}

function Vector.new(args)
	local self = setmetatable({}, {__index = Vector})

	self.abs = args.abs
	self.dir = args.dir

	self.x = args.x
	self.y = args.y

	protofs.fse.vectorList[self] = true

	return self
end
function Vector:destroy()
	protofs.fse.vectorList[self] = nil
end

function Vector:setPos(x, y)
	self.x, self.y = x, y
end
function Vector:getPos()
	return self.x, self.y
end

function Vector:getAttributes()
	return self
end

function Vector:draw(radius)
	love.graphics.circle("line", self.x, self.y, radius or protofs.conf.debug.vectorDrawSize)
end

function Vector:grap(x, y)
	local posX, posY = self:getPos()
	local distance = math.sqrt((x - posX)^2 + (y - posY)^2)
	return distance <= protofs.conf.debug.vectorDrawSize
end

_G.protofs.Vector = Vector
return Vector