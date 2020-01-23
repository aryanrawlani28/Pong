push = require 'push'

WINDOW_WIDTH = 1280 
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

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
    player1score = 0
    player2score = 0
    
    player1Y = 20
    player2Y = VIRTUAL_HEIGHT - 50
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        player1Y = player1Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    if love.keyboard.isDown('up') then
        player2Y = player2Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        player2Y = player2Y + PADDLE_SPEED * dt
    end
end

-- Called after updates
function love.draw()
    push:apply('start')

    love.graphics.printf(
        'Hello Pong!',           -- Text
        0,                       -- X Coord
        20,                      -- Y Coord
        VIRTUAL_WIDTH,           -- Width
        'center'                 -- Alignment
    )
    
    -- Player scores
    love.graphics.print(tostring(player1score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)


    -- Player boards
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH-10, player2Y, 5, 20)

    -- Pong Ball
    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT/2, 4, 4)

    push:apply('end')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end