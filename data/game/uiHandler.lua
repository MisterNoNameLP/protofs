local uiHandler = {}

local isDragging = false
local draggedVector

function uiHandler.init()

end

function uiHandler.update(dt)
	if love.mouse.isDown(1) then
		if isDragging then

		else
			for vector in pairs(protofs.fse.vectorList) do
				if vector:grap(love.mouse.getX(), love.mouse.getY()) then
					draggedVector = vector
					break
				end
			end
		end

		isDragging = true
	else
		isDragging = false
		draggedVector = false
	end

	if isDragging and draggedVector then
		draggedVector:setPos(love.mouse.getX(), love.mouse.getY())
	end
end

function uiHandler.draw()
	local vectorList = protofs.fse.vectorList
	
	if protofs.conf.debug.drawVectors then
		for v in pairs(vectorList) do
			v:draw()
		end
	end
end

protofs.uiHandler = uiHandler
return uiHandler