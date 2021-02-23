OverState = Class{__includes = BaseState}

function OverState:init()

end

function OverState:update(dt)
     if love.keyboard.wasPressed('escape') then
        gStateMachine:change('menu')
    end
    if Button_click(40,200,100,10) and  love.mouse.wasPressed(1) then
        gStateMachine:change('play')
    elseif Button_click(350,200,40,10) and  love.mouse.wasPressed(1) then
        gStateMachine:change('menu')
    end

end

function OverState:render()
    Button_draw(14)
    Button_draw(15)
    love.graphics.draw(gTextures['gover'], 10, 30)
    love.graphics.draw(gTextures['cscore'], 130, 100)
    love.graphics.draw(gTextures['hscore'], 130, 140)
    
    if Button_click(40,200,100,10) then
        love.graphics.draw(gSelect['sagain'], 39,199)
    elseif Button_click(350,200,40,10) then
        love.graphics.draw(gSelect['smenu'], 349,199)
    end
    
end
