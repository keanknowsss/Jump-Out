StoryState = Class{__includes = BaseState}



function StoryState:enter(params)
    gSounds['bgSpace']:setLooping(true)
    gSounds['bgSpace']:play()

    self.highScores = params.highScores
end


function StoryState:init()
    self.text1 = {opacity = 0}
    self.text2 = {opacity = 0}
    self.text3 = {opacity = 0}
    self.text4 = {opacity = 0}


    Timer.tween(2, 
        {[self.text1] = {opacity = 255}, [self.text4] = {opacity = 150}}):finish(function()
            Timer.after(3, function()
                Timer.tween(2, {[self.text1] = {opacity = 0}, [self.text2] = {opacity = 255}}):finish(function()
                    Timer.after(3, function()
                        Timer.tween(2, {[self.text2] = {opacity = 0}, [self.text3] = {opacity = 255}}):finish(function()
                            Timer.after(3, function()
                                Timer.tween(1, {[self.text3] = {opacity = 0}}):finish(function()
                                    gSounds['bgSpace']:stop()
                                    gStateMachine:change('menu',{highScores = self.highScores})
                                end)
                            end)
                        end)
                    end)
                end)
            end)
        end)
end



function StoryState:update(dt)
    Timer.update(dt)

    if love.keyboard.wasPressed('space') or love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('escape') or love.keyboard.wasPressed('return') then
        gSounds['bgSpace']:stop()
        gStateMachine:change('menu',{highScores = self.highScores})
    end
end



function StoryState:render()

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(1,1,1, self.text4.opacity/255)
    love.graphics.printf('(Press Enter or Space to skip)', 0, VIRTUAL_HEIGHT-20, VIRTUAL_WIDTH, 'center')

    
    love.graphics.setFont(gFonts['small'])

    love.graphics.setColor(1,1,1, self.text1.opacity/255)
    love.graphics.printf('What is out there in the Space?', 0, VIRTUAL_HEIGHT/3, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1,1,1, self.text2.opacity/255)
    love.graphics.printf('Is there an end to all of this?', 0, VIRTUAL_HEIGHT/3, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1,1,1, self.text3.opacity/255)
    love.graphics.printf('Only one way to find out . . .', 0, VIRTUAL_HEIGHT/3, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1,1,1,1) 
end
