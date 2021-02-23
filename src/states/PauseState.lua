PauseState = Class{__includes = BaseState}

function PauseState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('menu')
    end
     if Button_click(350,100,60,10) and  love.mouse.wasPressed(1) then
        gStateMachine:change('play')
    elseif Button_click(350,150,40,10) and  love.mouse.wasPressed(1) then
        gStateMachine:change('menu')
    end

end

function PauseState:render()
    Button_draw(16)
    Button_draw(17)
    love.graphics.draw(gTextures['paused'],130,5)
    love.graphics.draw(gTextures['title2'],60,70)
    if Button_click(350,100,60,10) then
        love.graphics.draw(gSelect['sresume'], 349,99)
    elseif Button_click(350,150,40,10) then
        love.graphics.draw(gSelect['smenu'], 349,149)
    end
    
end
