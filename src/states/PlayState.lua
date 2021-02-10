

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
    if self.paused then
        if love.keyboard.wasPressed('p') then
            gStateMachine:change('pause')
    end


    if self.jump then
        self.character:update(dt)
    end


end


function PlayState:render()
    self.character:render()
end
