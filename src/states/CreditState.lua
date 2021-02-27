CreditState = Class{__includes = BaseState}

function CreditState:enter(params)
    self.highScores = params.highScores
end

function CreditState:update(dt)
    bgMenuScroll = (bgMenuScroll + bgMenuScroll_Speed * dt) % bgMenuLooping
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('menu',{highScores = self.highScores})
    end
    
    if Button_click(380,200,40,10) and  love.mouse.wasPressed(1) then
        gStateMachine:change('menu',{highScores = self.highScores})
    end
end

function CreditState:render()
    love.graphics.draw(gBackgrounds['menubg'], -bgMenuScroll,0)

    love.graphics.draw(gTextures['glogo'], VIRTUAL_WIDTH/2 -50,20)
    love.graphics.draw(gTextures['jlogo'],VIRTUAL_WIDTH/2 - 35 ,130)

    Button_draw(6)
    if Button_click(380,200,40,10) then
        love.graphics.draw(gSelect['sback'], 379,199)
    end
end
