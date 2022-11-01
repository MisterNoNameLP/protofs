local fse = {
    
}

function fse.init(sizeX, sizeY)
    fse.fluidMatrix = loadfile("data/engine/FluidMatrix.lua")().new(
        sizeX, sizeY, loadfile("data/engine/FluidCell.lua")()
    )
end

function fse.update(dt)
    fse.fluidMatrix:update(dt)
end

function fse.draw(offsetX, offsetY, scale, gab)
    fse.fluidMatrix:draw(offsetX, offsetY, scale, gab)
end

return fse