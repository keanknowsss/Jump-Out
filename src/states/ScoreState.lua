ScoreState = Class{__includes = BaseState}

function ScoreState:update(dt)
    bgMenuScroll = (bgMenuScroll + bgMenuScroll_Speed * dt) % bgMenuLooping

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('menu')
    end
    if Button_click(350,40,40,10) and  love.mouse.wasPressed(1) then
        gStateMachine:change('menu')
    end

end

function ScoreState:render()
    love.graphics.draw(gBackgrounds['menubg'], -bgMenuScroll,0)
    Button_draw(13)
    love.graphics.draw(gTextures['title'], 35, 5)
    love.graphics.draw(gTextures['hstable'],90,70)
    if Button_click(350,40,40,10) then
        love.graphics.draw(gSelect['sback'], 349,39)
    end
end
