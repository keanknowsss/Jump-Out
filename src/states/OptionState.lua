OptionState = Class{__includes = BaseState}

function OptionState:update(dt)
   bgMenuScroll = (bgMenuScroll + bgMenuScroll_Speed * dt) % bgMenuLooping

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('menu')
    end
    if Button_click(380,200,40,10) and  love.mouse.wasPressed(1) then
        gStateMachine:change('menu')
    elseif Button_click(300,71,20,10) and  love.mouse.wasPressed(1) then --on1
        direcshooting = true
    elseif Button_click(300,101,20,10) and  love.mouse.wasPressed(1) then --on2
        gStateMachine:change('menu')
    elseif Button_click(300,131,20,10) and  love.mouse.wasPressed(1) then --on3
        gStateMachine:change('menu')
    elseif Button_click(350,71,30,10) and  love.mouse.wasPressed(1) then --off1
        direcshooting = false
    elseif Button_click(350,101,30,10) and  love.mouse.wasPressed(1) then --off2
        gStateMachine:change('menu')
    elseif Button_click(350,131,30,10) and  love.mouse.wasPressed(1) then --off3
        gStateMachine:change('menu')
    end

end

function OptionState:render()
    
    love.graphics.draw(gBackgrounds['menubg'], -bgMenuScroll,0)
    Button_draw(6)
    Button_draw(7)
    Button_draw(8)
    Button_draw(9)
    Button_draw(10)
    Button_draw(11)
    Button_draw(12)
    love.graphics.draw(gTextures['dshooting'], 20, 70)
    love.graphics.draw(gTextures['sound'], 20, 100)
    love.graphics.draw(gTextures['music'], 20, 130)

    if Button_click(380,200,40,10) then
        love.graphics.draw(gSelect['sback'], 379,199)
    elseif Button_click(300,71,20,10) then
        love.graphics.draw(gSelect['son'], 299,70)
    elseif Button_click(300,101,20,10) then
        love.graphics.draw(gSelect['son'], 299,100)
    elseif Button_click(300,131,20,10) then
        love.graphics.draw(gSelect['son'], 299,130)
    elseif Button_click(350,71,30,10) then
        love.graphics.draw(gSelect['soff'], 349,70)
    elseif Button_click(350,101,30,10) then
        love.graphics.draw(gSelect['soff'], 349,100)
    elseif Button_click(350,131,30,10) then
        love.graphics.draw(gSelect['soff'], 349,130)
    end
    
end
