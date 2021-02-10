OverState = Class{__includes = BaseState}

function OverState:init()

end

function OverState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('menu')
    elseif love.keyboard.wasPressed('a') then
        gStateMachine:change('play')
    end

end

function OverState:render()

    love.graphics.setFont(gFonts['huge'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('GAME OVER!', 10, 30, VIRTUAL_WIDTH, 'left')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('Score: ', 0, 100, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('High Score: ', 0, 130, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Play Again (A)', 70, 200, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('Menu (Esc)', -70, 200, VIRTUAL_WIDTH, 'right')
    
end