
Character = Class{}


function Character:init()
    self.height = 63
    self.width = 43

    -- flag for when the game is starting
    self.inPlay = false

    self.x = (VIRTUAL_WIDTH / 2 - 32) - self.width/2
    self.y = VIRTUAL_HEIGHT - 65 + self.height

    self.dy = 0

    self.inGame = false
    -- for the x velocity
    self.speed = 130

    -- for the y velocity
    self.jumpSpeed = -205

    self.direction = 'right'

    self.xscale = 1
    self.yscale = 1


    self.bullet = {}
    

    self.initializeJumpAni = Animation {
        frames = {1, 2, 3},
        interval = 0.2
    }
    self.jumpAnimation = Animation {
        frames = {4, 5, 6, 7, 8, 9, 10, 11},
        interval = 0.1
    }

    self.shootAnimation = Animation {
        frames = {13, 14, 15, 16, 17, 18, 19, 21},
        interval = 0.1
    }

    self.currentAnimation = self.initializeJumpAni

    self.scoreCounterY1 = self.y
    self.scoreCounterY2 = 0
    self.score1 = 0
    self.score2 = 0
    self.toScore = false
    

end




function Character:update(dt)


    self.currentAnimation:update(dt)

    if self.inGame then
        
    -- temporary scoring at the beginning of the game
    if self.dy == 0 then                        
        gSounds['jump']:play()
        self.scoreCounterY2 = self.y
        if self.scoreCounterY2 > self.scoreCounterY1 then
            self.score1 = self.scoreCounterY2 - self.scoreCounterY1
            self.scoreCounter1 = self.scoreCounterY2
        elseif self.scoreCounterY1 > self.scoreCounterY2 then
            self.score1 = self.scoreCounterY1 - self.scoreCounterY2
        elseif self.scoreCounterY1 == self.scoreCounterY2 then
            self.score1 = 0
        end

        self.currentAnimation.currentFrame = 7
        self.dy = self.jumpSpeed
        self.currentAnimation = self.jumpAnimation
    else
    end

    -- temporary scoring of the first blocks
    if self.score1 == self.score2 then
        self.score1 = 0
    elseif self.score1 > self.score2 then
        self.score1 = self.score1 - self.score2
    else
        self.score1 = 0
    end
    self.score2 = self.score1


    self.dy = self.dy + GRAVITY
    self.y = self.y + self.dy * dt
    

    if not self.inPlay then
        if self.y > VIRTUAL_HEIGHT - 65 + self.height  then
            self.dy = 0
            self.y = VIRTUAL_HEIGHT - 65 + self.height
        end    
    end





    -- limits the movement to avoid character continously moving upward bug
    if self.y < 30 then
        GRAVITY = 120
    else
        GRAVITY = 7
    end


    -- game is now using is down keys instead of toggle keys
    if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        self.x = self.x - self.speed * dt

        if self.dy == 0 then
            self.currentAnimation = self.jumpAnimation
        end

        self.direction = 'left'

        
        if self.x < -self.width - self.width / 2  then
            self.x = VIRTUAL_WIDTH + 20
        end

    elseif love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        self.x = self.x + self.speed * dt

        if self.dy == 0 then
            self.currentAnimation = self.jumpAnimation
        end

        self.direction = 'right'

        if self.x > VIRTUAL_WIDTH + self.width then
            self.x = -self.width + 20
        end
    else
        -- self.currentAnimation = self.jumpAnimation
    end


    if love.keyboard.wasPressed('space') then
        self.currentAnimation = self.shootAnimation

        gSounds['shoot']:stop()
        gSounds['shoot']:play()
        table.insert(self.bullet, Bullet(self.x - self.width/2, self.y - 15, self.direction))
    end


    if self.bullet then
        for k, bullet in pairs(self.bullet) do
            bullet:update(dt)
        end
    end

    end

end


function Character:render()
    love.graphics.draw(gTextures['sprites'], 
        gFrames['boy'][self.currentAnimation:getCurrentFrame()], 
        math.floor(self.x) - self.width/2, math.floor(self.y) - self.height/2, 
        0, 
        self.direction == 'left' and -1 or 1, self.yscale, self.width/2, self.height/2)


    if self.bullet then
        for k, bullet in pairs(self.bullet) do
            bullet:render()
        end
    end
end


-- DIFFERENT COLLISION FUNCTION FOR DIFFERENT OBJECTS

function Character:collidesPlatform(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x - self.width > target.x + target.width - 16 or target.x - 30 > self.x - self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height + 10 or target.y - 100 > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end



function Character:collidesInvertPlat(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x  + 40 or target.x - 20 > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end

function Character:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x - self.width > target.x + target.width - 20 or target.x > self.x then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y  > target.y + target.height + 40 or target.y > self.y then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end



function Character:collidesJet(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x - self.width + 10 > target.x + target.width or target.x + 10  > self.x then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.width + 25 or target.y + 20 > self.y then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end


function Character:collidesPowerup(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x - self.width - 5 > target.x + target.width or target.x  + self.width + 10> self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.width - 10 or target.y + self.height > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end




function Character:collidesPowerup2(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x - self.width > target.x + target.width or target.x + self.width + 10  > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height + self.height - 5 or target.y + self.height + 5> self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
    
end