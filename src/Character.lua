
Character = Class{}


function Character:init()
    self.height = 63
    self.width = 44

    -- flag for when the game is starting
    self.inPlay = false

    self.x = (VIRTUAL_WIDTH / 2 - 32) - self.width/2
    self.y = VIRTUAL_HEIGHT - 65 + self.height

    -- print(self.y)

    self.dx = 200
    self.dy = 0


    -- jumping animation constants
    self.jumpFPS = 13
    self.jumpTimer = 1/self.jumpFPS


    -- first frame
    self.jumpCurrent = 1

    -- number frames in the sheet
    self.jumpTotal = 12

    self.speed = 120
    self.jumpSpeed = -250

    self.direction = 'right'

    self.xscale = 1
    self.yscale = 1
    
    
    self.grounded = true
    self.jump = 'idle'
    self.motion = 'jumping'

    self.initializeJumpAni = Animation {
        frames = {1, 2, 3},
        interval = 0.2
    }
    self.jumpAnimation = Animation {
        frames = {4, 5, 6, 7, 8, 9, 10, 11},
        interval = 0.1
    }
    self.currentAnimation = self.initializeJumpAni

    
end




function Character:update(dt)
    self.currentAnimation = self.jumpAnimation


    -- when the player is falling call a flag
    if self.dy == 0 then
        self.currentAnimation.currentFrame = 7
        self.dy = self.jumpSpeed
        self.currentAnimation = self.jumpAnimation
        self.motion = 'falling'
    else
        self.motion = 'jumping'
    end

    self.dy = self.dy + GRAVITY
    self.y = self.y + self.dy * dt
    

    if not self.inPlay then
        if self.y > VIRTUAL_HEIGHT - 65 + self.height  then
            self.dy = 0
            self.y = VIRTUAL_HEIGHT - 65 + self.height
        end    
    end


    self.currentAnimation:update(dt)




    -- game is now using is down keys instead of toggle keys
    if love.keyboard.isDown('left') then
        self.x = self.x - self.speed * dt

        if self.dy == 0 then
            self.currentAnimation = self.jumpAnimation
        end

        self.direction = 'left'

        
        if self.x < -self.width - self.width / 2  then
            self.x = VIRTUAL_WIDTH + 20
        end

    elseif love.keyboard.isDown('right') then
        self.x = self.x + self.speed * dt

        if self.dy == 0 then
            self.currentAnimation = self.jumpAnimation
        end

        self.direction = 'right'

        if self.x > VIRTUAL_WIDTH + self.width then
            self.x = -self.width + 20
        end
    else
        self.currentAnimation = self.jumpAnimation
    end

end


function Character:render()
    love.graphics.draw(gTextures['character'], 
        gFrames['boy'][self.currentAnimation:getCurrentFrame()], 
        math.floor(self.x) - self.width/2, math.floor(self.y) - self.height/2, 
        0, 
        self.direction == 'left' and -1 or 1, self.yscale, self.width/2, self.height/2)
end


function Character:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x - self.width > target.x + target.width - 5 or target.x - 35 > self.x - self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height - 5 or target.y > self.y + self.height - 10 then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end

