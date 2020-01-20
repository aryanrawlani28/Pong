push = require 'push'

WINDOW_WIDTH = 1366 
WINDOW_HEIGHT = 768

VIRTUAL_HEIGHT = 640
VIRTUAL_WIDTH = 480

-- Startup function
function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    vsync = true,
    resizable = false
    })

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
        VIRTUAL_HEIGHT / 2, -- Y Coord
        VIRTUAL_WIDTH,          -- Width
        'center'               -- Alignment
    )              

    push:apply('end')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end