PauseState = Class{__includes = BaseState}

function PauseState:init()

end

function PauseState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('menu')
    elseif love.keyboard.wasPressed('r') then
        
    end

end

function PauseState:render()

    love.graphics.setFont(gFonts['huge'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('PAUSED', 0, 5 , VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('JUMP OUT', 60, 70 , VIRTUAL_WIDTH, 'left')
    love.graphics.printf('Resume (R)', -10, 100, VIRTUAL_WIDTH, 'right')
    love.graphics.printf('Menu (Esc)', -10, 150, VIRTUAL_WIDTH, 'right')
    
end