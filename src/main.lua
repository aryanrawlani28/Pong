WINDOW_WIDTH = 1366 
WINDOW_HEIGHT = 768

-- Startup function
function love.load()
    love.window.setMode(
        WINDOW_WIDTH, WINDOW_HEIGHT, {
            fullscreen = false,
            vsync = true,
            resizable = false
        }
    )
end

-- Called after updates
function love.draw()
    love.graphics.printf(
        'Hello Pong!', -- Text
        0,             -- X Coord
        WINDOW_HEIGHT / 2, -- Y Coord
        WINDOW_WIDTH,          -- Width
        'center')              -- Alignment
end