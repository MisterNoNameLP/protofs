local renderer = {
    scale = 100,
    gab = 10,
    color = {0, .4, .4},
}

function renderer.init()
    
end

function renderer.preDraw(fluidMatrix)
    love.graphics.setBackgroundColor(.7, .8, 1)
end

function renderer.afterDraw(fluidMatrix)

end

return renderer