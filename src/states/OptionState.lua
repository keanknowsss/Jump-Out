OptionState = Class{__includes = BaseState}

function OptionState:enter(params)
    self.highScores = params.highScores
end

function OptionState:init()
    
end

function OptionState:update(dt)

   bgMenuScroll = (bgMenuScroll + bgMenuScroll_Speed * dt) % bgMenuLooping

    if love.keyboard.wasPressed('escape') then
        gSounds['button']:play()
        gStateMachine:change('menu',{highScores = self.highScores})
    end
    if Button_click(380,200,40,10) and  love.mouse.wasPressed(1) then
        gSounds['button']:play()
        gStateMachine:change('menu',{highScores = self.highScores})
    elseif Button_click(300,71,20,10) and  love.mouse.wasPressed(1) then --on1
        gSounds['button']:play()
        direcshooting = true
    elseif Button_click(300,101,20,10) and  love.mouse.wasPressed(1) then --on2
        gSounds['button']:play()
        sounds = true
    elseif Button_click(300,131,20,10) and  love.mouse.wasPressed(1) then --on3
        gSounds['button']:play()
        gSounds['bgMenu']:play()
        music = true
    elseif Button_click(350,71,30,10) and  love.mouse.wasPressed(1) then --off1
        gSounds['button']:play()
        direcshooting = false
    elseif Button_click(350,101,30,10) and  love.mouse.wasPressed(1) then --off2
        gSounds['button']:play()
        sounds = false
    elseif Button_click(350,131,30,10) and  love.mouse.wasPressed(1) then --off3
        gSounds['button']:play()
        gSounds['bgMenu']:stop()
        music = false
    end



    
end

function OptionState:render()
    
    love.graphics.draw(gBackgrounds['menubg'], -bgMenuScroll,0)
    love.graphics.draw(gTextures['dshooting'], 20, 70)
    love.graphics.draw(gTextures['sound'], 20, 100)
    love.graphics.draw(gTextures['music'], 20, 130)
    Button_draw(6)

    if direcshooting == true then
        love.graphics.draw(gSelect['son'], 299,70)
        Button_draw(10)
    else
        Button_draw(7)
        love.graphics.draw(gSelect['soff'], 349,70)
    end
    
    if sounds == true then
        love.graphics.draw(gSelect['son'], 299,100)
        Button_draw(11)
    else
        Button_draw(8)
        love.graphics.draw(gSelect['soff'], 349,100)
    end
    
    if music == true then
        love.graphics.draw(gSelect['son'], 299,130)
        Button_draw(12)
    else
        Button_draw(9)
        love.graphics.draw(gSelect['soff'], 349,130)
    end

    if Button_click(380,200,40,10) then
        love.graphics.draw(gSelect['sback'], 379,199)    
    end
    
end

