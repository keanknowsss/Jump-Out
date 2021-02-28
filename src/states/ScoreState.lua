ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
    self.highScores = params.highScores
end

function ScoreState:update(dt)
    bgMenuScroll = (bgMenuScroll + bgMenuScroll_Speed * dt) % bgMenuLooping

    if love.keyboard.wasPressed('escape') then
        gSounds['button']:play()
        gStateMachine:change('menu',{highScores = self.highScores})
    end
    if Button_click(350,40,40,10) and  love.mouse.wasPressed(1) then
        gSounds['button']:play()
        gStateMachine:change('menu',{highScores = self.highScores})
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

    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(gFonts['score'])
    love.graphics.print(self.highScores[1].name,110,95)
    love.graphics.print(tostring(self.highScores[1].score),170,95)
    love.graphics.print(self.highScores[2].name,110,123)
    love.graphics.print(tostring(self.highScores[2].score),170,123)
    love.graphics.print(self.highScores[3].name,110,150)
    love.graphics.print(tostring(self.highScores[3].score),170,150)
    love.graphics.print(self.highScores[4].name,110,175)
    love.graphics.print(tostring(self.highScores[4].score),170,175)
    love.graphics.print(self.highScores[5].name,110,200)
    love.graphics.print(tostring(self.highScores[5].score),170,200)
    love.graphics.print(self.highScores[6].name,235,95)
    love.graphics.print(tostring(self.highScores[6].score),295,95)
    love.graphics.print(self.highScores[7].name,235,123)
    love.graphics.print(tostring(self.highScores[7].score),295,123)
    love.graphics.print(self.highScores[8].name,235,150)
    love.graphics.print(tostring(self.highScores[8].score),295,150)
    love.graphics.print(self.highScores[9].name,235,175)
    love.graphics.print(tostring(self.highScores[9].score),295,175)
    love.graphics.print(self.highScores[10].name,235,200)
    love.graphics.print(tostring(self.highScores[10].score),295,200)
end
