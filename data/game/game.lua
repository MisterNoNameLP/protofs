local game = {}

local gotError = false
local frame = 0

local lastLerpVector --for cleanup purpose

--===== shorts =====--
local g = love.graphics
local V = protofs.Vector

--===== local vars =====--
local v1, v2, v3, v4 = V.new({x = 0, y = 0}), V.new({x = 100, y = 100}), V.new({x = 200, y = 200}), V.new({x = 300, y = 300})

--===== local functions =====--
local function lerp(vector1, vector2, t)
	local v1 = vector1:getAttributes()
	local v2 = vector2:getAttributes()

	local x = (1 - t) * v1.x + t * v2.x
	local y = (1 - t) * v1.y + t * v2.y

	if lastLerpVector then
		lastLerpVector:destroy()
	end

	lastLerpVector = protofs.Vector.new({x = x, y = y})
	lastLerpVector:draw(1)
	return lastLerpVector
end

--===== engine functions =====--
function game.init(orgFSE, orgRenderer)
	print("game init")
end

function game.update(dt)
	
end

function game.draw()
	local steps = 10
	for t = 0, 1, 1 / steps do
		--local x, y = lerp(v1, v2, t)
		local point1 = lerp(v1, v2, t)
		local point2 = lerp(v3, v4, t)
		local x, y = lerp(point1, point2, t):getPos()
		
		g.circle("fill", x, y, 3)
	end
	lastLerpVector:destroy()

end

return game