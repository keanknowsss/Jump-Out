
Character = Class{}


function Character:init()
    self.height = 63
    self.width = 44


    self.x = VIRTUAL_WIDTH / 2 - 32
    self.y = VIRTUAL_HEIGHT - 64


    self.dx = 0 
    self.dy = 0


    -- jumping animation constants
    self.jumpCounter = 0
    self.jumpMax = 0.13


    self.jumpCurrent = 2
    self.jumpNumber = 7
end




function Character:update(dt)

    -- shuffles through all animation frames of jump

    

    self.jumpCounter = self.jumpCounter + dt
    if self.jumpCounter > self.jumpMax then
        
        -- jumps according to the specific frame
        if self.jumpCurrent >= 5 then
            self.dy = self.dy + 500
        elseif self.jumpCurrent > 2 then
            self.dy = -(self.dy + 500) 
        else
            self.dy = 0
        end

    
       self.jumpCounter = self.jumpCounter - self.jumpMax
       self.jumpCurrent = self.jumpCurrent  % self.jumpNumber + 1
       self.y = self.y + self.dy * dt
       self.dy = 0
    end



    -- checks to see if character is below the lower part of the screen
    if self.y > VIRTUAL_HEIGHT - 64 then
        self.dy = 0
        self.y = VIRTUAL_HEIGHT - 64
    end


    if love.keyboard.isDown('right') then
        self.dx = 100
        self.x = self.x + self.dx * dt *1.5

        if self.x > VIRTUAL_WIDTH then
            self.x = -self.width + 5
        end
    end
end


function Character:render()
    love.graphics.draw(gTextures['character'], gFrames['boy'][self.jumpCurrent], self.x, self.y)
end