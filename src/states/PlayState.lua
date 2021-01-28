

PlayState = Class{__includes = BaseState}


function PlayState:init()
    self.character = Character()

    self.paused = false

    self.jump = false
end



function PlayState:update(dt)
    -- terminates the game
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end


    -- pauses the game
    if self.paused then
        if love.keyboard.wasPressed('p') then
            self.paused = false
        else
            return
        end
    elseif love.keyboard.wasPressed('p') then
        self.paused = true
        return
    end


    -- checks input before the character jump
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        self.jump = true
    end


    if self.jump then
        self.character:update(dt)
    end


end


function PlayState:render()
    self.character:render()
end