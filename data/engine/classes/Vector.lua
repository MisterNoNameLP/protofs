local Vector = {}

function Vector.new(argTbl, ...)
	local self = setmetatable({}, {
   __index = Vector,
   __tostring = Vector.tostring,
   __call = Vector.call
   })
	
	local args = {...}
	argTbl = argTbl or {}
	self.abs = argTbl.abs or args[1]
	self.dir = argTbl.dir or args[2]
	self.x = argTbl.x or args[3]
	self.y = argTbl.y or args[4]
	
	self.wid = argTbl.wid or args[5]
	return self
end

function Vector:tostring()
	local ts = function(foo)
		if type(foo) == "number" then
			return tostring(math.floor(foo))
		else
			return tostring(foo)
		end
	end
	return "Vector: " .. ts(self.abs) .. " " .. ts(self.dir) .. " " ..  ts(self.x) .. " " .. ts(self.y)
end

function Vector:call()
	return self.abs, self.dir, self.x, self.y
end

function Vector:getRelativeAngle(other)
	local deltaX, deltaY = other.x - self.x, other.y - self.y
	local distance = math.sqrt(deltaX^2 + deltaY^2)
	local angle = math.deg(math.atan2(deltaX, deltaY))
	if angle > 180 then angle = -180 + (angle - 180) end
	return Vector.new({abs = distance, dir = angle})
end

function Vector:getRelativePos(other)
	local newPosX, newPosY = 0, 0
   local dir = other.dir
	newPosX = self.x + other.abs * math.sin(math.rad(dir))
	newPosY = self.y + other.abs * math.cos(math.rad(dir))
	return Vector.new({x = newPosX, y = newPosY})
end

function Vector:getCorners() --chatGPT
	local dx = math.sin(math.rad(self.dir + 90)) * self.wid / 2
	local dy = math.cos(math.rad(self.dir + 90)) * self.wid / 2
	local selfEndpoints = self:getRelativePos(self)
	return {
		{x = self.x - dx, y = self.y - dy},
		{x = self.x + dx, y = self.y + dy},
		{x = selfEndpoints.x + dx, y = selfEndpoints.y + dy},
		{x = selfEndpoints.x - dx, y = selfEndpoints.y - dy}
	}
end

function linesIntersect(x1, y1, x2, y2, x3, y3, x4, y4) --chatGPT
	local function ccw(Ax, Ay, Bx, By, Cx, Cy)
		return (Cy - Ay) * (Bx - Ax) > (By - Ay) * (Cx - Ax)
	end

	return ccw(x1, y1, x3, y3, x4, y4) ~= ccw(x2, y2, x3, y3, x4, y4) and ccw(x1, y1, x2, y2, x3, y3) ~= ccw(x1, y1, x2, y2, x4, y4)
end

function Vector:checkOverlap(other) --chatGPT
	local selfEndpoints = self:getRelativePos(self)
	local otherEndpoints = other:getRelativePos(other)
	return linesIntersect(self.x, self.y, selfEndpoints.x, selfEndpoints.y, other.x, other.y, otherEndpoints.x, otherEndpoints.y)
end

function rectanglesOverlap(rect1, rect2) --chatGPT
	for i = 1, 4 do
		local j = (i % 4) + 1
		for k = 1, 4 do
			local l = (k % 4) + 1
			if linesIntersect(rect1[i].x, rect1[i].y, rect1[j].x, rect1[j].y, rect2[k].x, rect2[k].y, rect2[l].x, rect2[l].y) then
				return true
			end
		end
	end
	return false
end

function Vector:checkOverlapRect(other) --chatGPT
	local selfCorners = self:getCorners()
	local otherCorners = other:getCorners()
	return rectanglesOverlap(selfCorners, otherCorners)
end

return Vector