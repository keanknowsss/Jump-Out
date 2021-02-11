

PlayState = Class{__includes = BaseState}


function PlayState:init()
    self.character = Character()

    self.jump = true
end



function PlayState:update(dt)
    -- terminates the game
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('menu')
    end


    -- pauses the game
    if love.keyboard.wasPressed('p') then
        gStateMachine:change('pause')
    end



    if self.jump then
        self.character:update(dt)
    end



    
end


function PlayState:render()
    love.graphics.draw(gTextures['city'], 0,0, 0, 0.25, 0.25, gTextures['city']:getWidth()/2, VIRTUAL_HEIGHT - 60)
    displayFPS()
    self.character:render()
end


-- displays FPS to screen
function displayFPS()
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 1, 0, 1)

    love.graphics.print('FPS: '.. tostring(love.timer.getFPS()), 5, 5)
    love.graphics.setColor(1,1,1,1)
end

