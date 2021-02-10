CreditState = Class{__includes = BaseState}

function CreditState:init()

end

function CreditState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('menu')
    end
end

function CreditState:render()
    love.graphics.draw(gTextures['glogo'], VIRTUAL_WIDTH/2 -50,20)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('Back (Esc)', -10, 200, VIRTUAL_WIDTH, 'right')
    
end