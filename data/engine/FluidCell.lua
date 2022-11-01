local FluidCell = {}

function FluidCell.new()
    local self = setmetatable({}, {__index = FluidCell})

    _G.protofs.debugInfo.cellCount = _G.protofs.debugInfo.cellCount +1
    self.id = _G.protofs.debugInfo.cellCount

    self.color = {0, .3, .6}




    return self
end

function FluidCell:update(dt, matrix)
    --print("fluidCell" .. tostring(self.id) .. ": update")
end

function FluidCell:draw(posX, posY, offsetX, offsetY, scale, gab)
    --print("fluidCell" .. tostring(self.id) .. ": draw")

    local renderPosX = posX * scale + gab * posX + offsetX
    local renderPosY = posY * scale + gab * posY + offsetY

    self.color[4] = 1 --alpha

    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", 
        renderPosX, 
        renderPosY,
        scale, 
        scale
    )
end

return FluidCell