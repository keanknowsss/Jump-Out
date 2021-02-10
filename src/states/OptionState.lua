OptionState = Class{__includes = BaseState}

function OptionState:init()

end

function OptionState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('menu')
    elseif love.keyboard.wasPressed('d') then
        
    elseif love.keyboard.wasPressed('e') then
        
    elseif love.keyboard.wasPressed('f') then
        
    elseif love.keyboard.wasPressed('l') then
        
    elseif love.keyboard.wasPressed('m') then

    elseif love.keyboard.wasPressed('n') then

    end

end

function OptionState:render()

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('Directional Shooting', 20, 70, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('ON(L)       OFF(D)', -10, 70, VIRTUAL_WIDTH, 'right')
    love.graphics.printf('Sound Effects', 20, 100, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('ON(M)       OFF(E)', -10, 100, VIRTUAL_WIDTH, 'right')
    love.graphics.printf('Music', 20, 130, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('ON(N)       OFF(F)', -10, 130, VIRTUAL_WIDTH, 'right')
    love.graphics.printf('Back (Esc)', -10, 200, VIRTUAL_WIDTH, 'right')
    
end