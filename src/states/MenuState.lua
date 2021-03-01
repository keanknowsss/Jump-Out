MenuState = Class{__includes = BaseState}


function MenuState:enter(params)
    gSounds['bgCity']:stop()
    gSounds['bgMenu']:play()
    self.highScores = params.highScores

end


function MenuState:init()
    self.character = Character()
    self.character.currentAnimation = self.character.jumpAnimation
    self.character.x, self.character.y = 200, VIRTUAL_HEIGHT/2 - 10 - self.character.height
end

function MenuState:update(dt)
     bgMenuScroll = (bgMenuScroll + bgMenuScroll_Speed * dt) % bgMenuLooping
    
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play',{highScores = self.highScores})
    elseif love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if Button_click(190,160,64,17) and  love.mouse.wasPressed(1) then
        gSounds['button']:play()
        gStateMachine:change('play',{highScores = self.highScores})
    elseif Button_click(10,220,100,10) and  love.mouse.wasPressed(1) then
        gSounds['button']:play()
        gStateMachine:change('score',{highScores = self.highScores})
    elseif Button_click(380,220,40,10) and  love.mouse.wasPressed(1) then
        gSounds['button']:play()
        love.event.quit()
    elseif Button_click(350,10,70,10) and  love.mouse.wasPressed(1) then
        gSounds['button']:play()
        gStateMachine:change('option',{highScores = self.highScores})
    elseif Button_click(350,30,70,10) and  love.mouse.wasPressed(1) then
        gSounds['button']:play()
        gStateMachine:change('credit',{highScores = self.highScores})

    end


    self.character:update(dt)

    if self.character.dy == 0 then
        self.character.currentAnimation.currentFrame = 7
        self.character.dy = self.character.jumpSpeed
    end

    self.character.dy = self.character.dy + GRAVITY
    self.character.y = self.character.y + self.character.dy * dt

    if self.character.y > VIRTUAL_HEIGHT/2 - 10  then
        self.character.dy = 0
        self.character.y = VIRTUAL_HEIGHT/2 - 10
    end    
end

function MenuState:render()

    love.graphics.draw(gBackgrounds['menubg'], -bgMenuScroll,0)
    self.character:render()
    -- love.graphics.draw(gTextures['jlogo'],187,30)
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
