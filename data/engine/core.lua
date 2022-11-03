local core = {}
local love = love
local fse, renderer, game

local gotError = false
local frame = 0

function core.init(orgFSE, orgRenderer, orgGame)
    fse, renderer, game = orgFSE, orgRenderer, orgGame
end

function love.update(dt)
    frame = frame + 1
    if gotError then
        print("Frame: " .. tostring(frame))
        print("Reloaded: " .. tostring(_G.reloaded))
        _G.reloaded = _G.reloaded + 1
        love.timer.sleep(1)
        gotError = false

        loadfile("data/init.lua")()
    end

    local suc, err = xpcall(function(dt) 
        if love.keyboard.isDown("r") then
            loadfile("data/init.lua")()
        end

        fse.update(dt)
        game.update(dt)
    end, debug.traceback, dt)

    if suc ~= true then
        print("=== UPDATE ERROR ===")
        print(suc, err)
        gotError = true
    end

end

function love.draw()
    local suc, err = xpcall(function(dt) 
        renderer.preDraw()
        fse.draw(-50, -50, 75, 3)
        renderer.afterDraw()
        game.draw()
    end, debug.traceback, dt)

    if suc ~= true then
        print("=== DRAW ERROR ===")
        print(suc, err)
        gotError = true
    end
end

return core