local FluidCell = {}

local color = {0, .3, .6}

--no contructor needed. object gets constructed in the FluidMatrix.

function FluidCell:update(dt, matrix)
    
end

function FluidCell:draw(posX, posY, offsetX, offsetY, scale, gab)
    local renderPosX = posX * scale + gab * posX + offsetX
    local renderPosY = posY * scale + gab * posY + offsetY

    --print(self.amount)

    --color[4] = 1 --alpha
    color[4] = self.amount * .75 + .25

    love.graphics.setColor(color)
    love.graphics.rectangle("fill", 
        renderPosX, 
        renderPosY,
        scale, 
        scale
    )
end

return FluidCell