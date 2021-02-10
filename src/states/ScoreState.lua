ScoreState = Class{__includes = BaseState}

function ScoreState:init()

end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('menu')
    end

end

function ScoreState:render()
    love.graphics.setFont(gFonts['huge'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('JUMP OUT', 35, 20, VIRTUAL_WIDTH, 'left')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('Scores', 35, 60, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('Back (Esc)', -20, 40, VIRTUAL_WIDTH, 'right')

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('1.', 45, 90, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('2.', 45, 105, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('3.', 45, 120, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('4.', 45, 135, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('5.', 45, 150, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('6.', 45, 165, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('7.', 45, 180, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('8.', 45, 195, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('9.', 45, 205, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('10.', 45, 220, VIRTUAL_WIDTH, 'left')
end