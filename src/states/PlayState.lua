

PlayState = Class{__includes = BaseState}


function PlayState:init()
    self.character = Character()

    self.jump = true
end



function PlayState:update(dt)
    
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('menu')
    end


    -- pauses the game
    if Button_click(390,5,25,8) and  love.mouse.wasPressed(1) then
        gStateMachine:change('pause')
    end



    if self.jump then
        self.character:update(dt)
    end



    
end


function PlayState:render()
    love.graphics.draw(gBackgrounds['city'], 0,-2150)
    displayFPS()
    self.character:render()
    love.graphics.draw(gTextures['pscore'],5,15)
    Button_draw(18)
    if Button_click(390,5,25,8) then
        love.graphics.draw(gSelect['spause'], 389,4)
    end
end


-- displays FPS to screen
function displayFPS()
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 1, 0, 1)

    love.graphics.print('FPS: '.. tostring(love.timer.getFPS()), 5, 5)
    love.graphics.setColor(1,1,1,1)
end

