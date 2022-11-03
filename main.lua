--LÖVE main file 
local version = "v0.0.2"

function love.load(args)
    --debug stuff
    _G.reloaded = 0

	loadfile("data/init.lua")()

    return 0
end