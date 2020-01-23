push = require 'push'

Class = require 'class'

require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280 
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

-- Startup function
function love.load()
    
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle("Pong!")
    
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })
    
    --love.graphics.clear(40/255, 45/255, 52/255, 1)
    
    player1Score = 0
    player2Score = 0

    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
    
    gameState = 'start'
    
end

function love.update(dt)

    -- Collision update:
    if gameState == 'play' then
        
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 5

            -- velocity goes in same dir but now randomized
            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end
        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - 4

            -- velocity goes in same dir but now randomized
            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end

        -- detect upper and lower screen boundary collision and reverse if collided
        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
        end

        -- -4 to account for the ball's size
        if ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.y = VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy
        end
    end

    if ball.x < 0 then
        servingPlayer = 1
        player2Score = player2Score + 1
        ball:reset()
        gameState = 'start'
    end

    if ball.x > VIRTUAL_WIDTH then
        servingPlayer = 2
        player1Score = player1Score + 1
        ball:reset()
        gameState = 'start'
    end

    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
        --player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        --player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    if love.keyboard.isDown('up') then
        --player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt )
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        --player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

-- Called after updates
function love.draw()
    push:apply('start')

    love.graphics.clear(40/255, 45/255, 52/255, 1)
    -- love.graphics.printf(
    --     'Hello Pong!',           -- Text
    --     0,                       -- X Coord
    --     20,                      -- Y Coord
    --     VIRTUAL_WIDTH,           -- Width
    --     'center'                 -- Alignment
    -- )
    
    -- -- Player scores
    -- love.graphics.print(tostring(player1score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    -- love.graphics.print(tostring(player2score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)


    -- -- Player boards
    -- love.graphics.rectangle('fill', 10, player1Y, 5, 20)
    -- love.graphics.rectangle('fill', VIRTUAL_WIDTH-10, player2Y, 5, 20)

    -- -- Pong Ball
    -- love.graphics.rectangle('fill', ballX, ballY, 4, 4)

    if gameState == 'start' then
        love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
    end

    player1:render()
    player2:render()

    ball:render()
    displayFPS() 

    push:apply('end')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            ball:reset()
        end
    end
end

function displayFPS()
    love.graphics.setColor(0, 255, 0, 255)
    -- String concat op ".."
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
