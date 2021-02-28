
PlayerJetpack = Class{}


function PlayerJetpack:init(x,y)
    self.x = x
    self.y = y


    self.height = 63
    self.width = 52


    self.dy = -120
    self.speed = 400

    self.xscale = 1
    self.yscale = 1


    self.direction = 'right'

    self.jetAnimation = Animation {
        frames = {22, 23, 24, 25, 26},
        interval = 0.4
    }

    self.currentAnimation = self.jetAnimation
end


function PlayerJetpack:update(dt)
    self.y = math.max(100, self.y + self.dy * dt)

    self.currentAnimation:update(dt)


    -- game is now using is down keys instead of toggle keys
    if love.keyboard.isDown('left') then
        self.x = self.x - self.speed * dt

        self.direction = 'left'
        
        if self.x < -self.width - self.width / 2  then
            self.x = VIRTUAL_WIDTH + 20
        end

    elseif love.keyboard.isDown('right') then
        self.x = self.x + self.speed * dt

        self.direction = 'right'

        if self.x > VIRTUAL_WIDTH + self.width then
            self.x = -self.width + 20
        end
    end
end


function PlayerJetpack:render()
    love.graphics.draw(gTextures['sprites'], 
        gFrames['boy'][self.currentAnimation:getCurrentFrame()], 
        math.floor(self.x) - self.width/2, math.floor(self.y) - self.height/2, 
        0, 
        self.direction == 'left' and -1 or 1, self.yscale, self.width/2, self.height/2)
end