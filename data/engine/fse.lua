local fse = {
    
}

function fse.init(sizeX, sizeY)
    local func, err = loadfile("data/engine/FluidMatrix.lua")

    while true do
        if func == nil then
            print("FSE init error")
            print(err)
            love.timer.sleep(1)
            func, err = loadfile("data/engine/FluidMatrix.lua")
        else
            fse.fluidMatrix = loadfile("data/engine/FluidMatrix.lua")({
                FluidCell = loadfile("data/engine/FluidCell.lua")(),
            }).new(
                sizeX, sizeY
            )
            break
        end
    end
end

function fse.update(dt)
    fse.fluidMatrix:update(dt)
end

function fse.draw(offsetX, offsetY, scale, gab)
    fse.fluidMatrix:draw(offsetX, offsetY, scale, gab)
end

return fse