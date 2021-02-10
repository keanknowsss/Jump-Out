MenuState = Class{__includes = BaseState}

function MenuState:init()

end

function MenuState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    elseif love.keyboard.wasPressed('h') then
        gStateMachine:change('score')
    elseif love.keyboard.wasPressed('escape') then
        love.event.quit()
    elseif love.keyboard.wasPressed('o') then
        gStateMachine:change('option')
    elseif love.keyboard.wasPressed('c') then
        gStateMachine:change('credit')
    end

end

function MenuState:render()

    love.graphics.setFont(gFonts['huge'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('JUMP OUT', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('Press Enter to Play', 0, 130, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('High Score (H)', 10, 200, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('Exit (Esc)', -10, 200, VIRTUAL_WIDTH, 'right')
    love.graphics.printf('Options (O)', -10, 10, VIRTUAL_WIDTH, 'right')
    love.graphics.printf('Credits (C)', -10, 30, VIRTUAL_WIDTH, 'right')
    
end
