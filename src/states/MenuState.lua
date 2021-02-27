MenuState = Class{__includes = BaseState}


function MenuState:enter(params)

    gSounds['bgMenu']:play()
    self.highScores = params.highScores
end

function MenuState:update(dt)
     bgMenuScroll = (bgMenuScroll + bgMenuScroll_Speed * dt) % bgMenuLooping
    
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play',{highScores = self.highScores})
    elseif love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if Button_click(190,160,64,17) and  love.mouse.wasPressed(1) then
        gStateMachine:change('play',{highScores = self.highScores})
    elseif Button_click(10,220,100,10) and  love.mouse.wasPressed(1) then
        gStateMachine:change('score',{highScores = self.highScores})
    elseif Button_click(380,220,40,10) and  love.mouse.wasPressed(1) then
        love.event.quit()
    elseif Button_click(350,10,70,10) and  love.mouse.wasPressed(1) then
        gStateMachine:change('option',{highScores = self.highScores})
    elseif Button_click(350,30,70,10) and  love.mouse.wasPressed(1) then
        gStateMachine:change('credit',{highScores = self.highScores})

    end

end

function MenuState:render()

    love.graphics.draw(gBackgrounds['menubg'], -bgMenuScroll,0)
    love.graphics.draw(gTextures['jlogo'],187,30)
    love.graphics.draw(gTextures['title'], 134, 110)
    Button_draw(1)
    Button_draw(2)
    Button_draw(3)
    Button_draw(4)
    Button_draw(5)

    if Button_click(190,160,64,17) then
        love.graphics.draw(gSelect['splay'], 189,159)
    elseif Button_click(10,220,100,10) then
        love.graphics.draw(gSelect['sscore'], 9,219)
    elseif Button_click(380,220,40,10) then
        love.graphics.draw(gSelect['sexit'], 379,219)
    elseif Button_click(350,10,70,10) then
        love.graphics.draw(gSelect['soption'], 349,9)
    elseif Button_click(350,30,70,10) then
        love.graphics.draw(gSelect['scredit'], 349,29)
    end
end
