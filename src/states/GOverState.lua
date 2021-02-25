
GOverState = Class{__includes = BaseState}

function GOverState:enter(params)
    self.highScores = params.highScores
    self.score = params.score
end

function GOverState:init()
end

function GOverState:update(dt)
    bgMenuScroll = (bgMenuScroll + bgMenuScroll_Speed * dt) % bgMenuLooping

    if Button_click(40,200,100,10) and  love.mouse.wasPressed(1) then
        gStateMachine:change('play',{highScores = self.highScores})
    elseif Button_click(350,200,40,10) and  love.mouse.wasPressed(1) then
        gStateMachine:change('menu',{highScores = self.highScores})
    end

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('menu',{highScores = self.highScores})
    end


end

function GOverState:render()
    love.graphics.draw(gBackgrounds['menubg'], -bgMenuScroll,0)
    Button_draw(14)
    Button_draw(15)
    love.graphics.draw(gTextures['gover'], 10, 10)
    love.graphics.draw(gTextures['cscore'], 130, 90)
    love.graphics.draw(gTextures['hscore'], 130, 120)
    
    if Button_click(40,200,100,10) then
        love.graphics.draw(gSelect['sagain'], 39,199)
    elseif Button_click(350,200,40,10) then
        love.graphics.draw(gSelect['smenu'], 349,199)
    end

    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.print(tostring(self.score), 187, 97)
    love.graphics.print(tostring(self.highScores[1].score), 232, 126)
    

end