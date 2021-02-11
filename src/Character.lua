
Character = Class{}


function Character:init()
    self.height = 63
    self.width = 44


    self.x = VIRTUAL_WIDTH / 2 - 32
    self.y = VIRTUAL_HEIGHT - 35


    self.dx = 0 
    self.dy = 0


    -- jumping animation constants
    self.jumpFPS = 11
    self.jumpTimer = 1/self.jumpFPS

    self.jumpCurrent = 1
    self.jumpTotal = 9

    self.speed = 1000

    self.direction = 'none'

    self.xscale = 1
    self.yscale = 1
    
    
    self.grounded = true
end




function Character:update(dt)

    -- shuffles through all animation frames of jump

    

    self.jumpTimer = self.jumpTimer - dt
    if self.jumpTimer <= 0 then
        

        -- jumps according to the specific frame
        if self.jumpCurrent >= 7 then
            self.dy = self.dy + self.speed
        elseif self.jumpCurrent > 2 then
            self.dy = -(self.speed) 
        else
            self.dy = 0
        end

        self.jumpTimer = 1/self.jumpFPS

        self.jumpCurrent = self.jumpCurrent + 1
        if self.jumpCurrent > 9 then
            self.jumpCurrent = 3
            self.jumpFPS = 9
            self.y = VIRTUAL_HEIGHT - 35
        end


       self.y = self.y + self.dy * dt
       self.dy = 0
    end


    if love.keyboard.wasPressed('right') then
        self.direction = 'right'
        self.xscale = math.abs(self.xscale)
    elseif love.keyboard.wasPressed('left') then
        self.direction = 'left'
        self.xscale = -math.abs(self.xscale)
    end
    -- checks to see if character is below the lower part of the screen
    if self.y > VIRTUAL_HEIGHT - 35 then
        self.dy = 0
        self.y = VIRTUAL_HEIGHT - 35
    end



    if self.jumpCurrent > 2 then
        if self.direction == 'right' then
            self.dx = 150
            self.x = self.x + self.dx * dt 
        
            if self.x > VIRTUAL_WIDTH + self.width/2 then
                self.x = -self.width + 5
            end
        elseif self.direction == 'left' then
            self.dx = -150
            self.x = self.x + self.dx * dt 
        
            if self.x < -self.width - self.width/2 then
                self.x = VIRTUAL_WIDTH + 5
            end
        end
    end

end


function Character:render()
    love.graphics.draw(gTextures['character'], gFrames['boy'][self.jumpCurrent], self.x, self.y, 0, self.xscale, self.yscale, self.width/2 + 4, self.height/2)
end

