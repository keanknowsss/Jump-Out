

Spring = Class{}


function Spring:init(x, y)
    self.x = x
    self.y = y

    self.height = 16
    self.width = 16

    self.dy = 100

    self.idleAnimation = Animation {
        frames = {1, 2},
        interval = 0.5
    }

    self.activatedAnimation = Animation {
        frames = {3, 4, 5},
        interval = 0.1
    }

    self.currentAnimation = self.idleAnimation


    self.remove = false

end



function Spring:update(dt)
    self.currentAnimation:update(dt)


    if self.y > VIRTUAL_HEIGHT + 16 then
        self.remove = true
    end
end

function Spring:render()
    love.graphics.draw(gTextures['spring'], gFrames['spring'][self.currentAnimation:getCurrentFrame()], self.x, self.y, 0, 2,2)
end


-- for the moving down function
function Spring:downMove(dt)
    self.y = self.y + self.dy * dt
end