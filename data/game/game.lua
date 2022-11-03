local game = {}
local love = love
local fse, renderer 

local gotError = false
local frame = 0

function game.init(orgFSE, orgRenderer)
    fse, renderer = orgFSE, orgRenderer
    print("game init")


end

function game.update(dt)
    
    fse.fluidMatrix:setCell(2, 2, fse.fluidMatrix.getNewCell({amount = .2}))
    fse.fluidMatrix:setCell(3, 2, fse.fluidMatrix.getNewCell({amount = .4}))
    fse.fluidMatrix:setCell(4, 2, fse.fluidMatrix.getNewCell({amount = .6}))
    fse.fluidMatrix:setCell(5, 2, fse.fluidMatrix.getNewCell({amount = .8}))
    fse.fluidMatrix:setCell(6, 2, fse.fluidMatrix.getNewCell({amount = 1}))
end

function game.draw()
    
end

return game