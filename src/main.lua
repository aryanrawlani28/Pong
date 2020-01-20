push = require 'push'

WINDOW_WIDTH = 1280 
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- Startup function
function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    vsync = true,
    resizable = false
    })

    love.graphics.clear(40/255, 45/255, 52/255, 1)

    --[[
        love.window.setMode(
        WINDOW_WIDTH, WINDOW_HEIGHT, {
        }
    )
    ]]--
end

-- Called after updates
function love.draw()
    push:apply('start')

    love.graphics.printf(
        'Hello Pong!', -- Text
        0,             -- X Coord
        20, -- Y Coord
        VIRTUAL_WIDTH,          -- Width
        'center'               -- Alignment
    )              

    love.graphics.rectangle('fill', 10, 30, 5, 20)

    love.graphics.rectangle('fill', VIRTUAL_WIDTH-10, VIRTUAL_HEIGHT-50, 5, 20)

    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT/2, 4, 4)

    push:apply('end')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end