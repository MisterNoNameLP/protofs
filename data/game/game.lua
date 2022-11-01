local game = {}
local love = love
local fse, renderer

function game.init(orgFSE, orgRenderer)
    fse, renderer = orgFSE, orgRenderer
end

function love.update(dt)
    if love.keyboard.isDown("r") then
        loadfile("data/init.lua")()
    end

    fse.update(dt)
end

function love.draw()
    renderer.preDraw()
    fse.draw(-50, -50, 75, 3)
    renderer.afterDraw()
end

return game