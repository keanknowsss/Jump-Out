
Jetpack = Class{}


function Jetpack:init(x, y)
    self.x = x
    self.y = y

    self.width = 28
    self.height = 32


    self.dy = 100

    self.remove = false
end


function Jetpack:update(dt)

    if self.y > VIRTUAL_HEIGHT + 40 then
        self.remove = true
    else
        self.y = self.y + self.dy * dt
    end
    
end


function Jetpack:render()
    love.graphics.draw(gTextures['jetpack'], self.x, self.y, 0, 2, 2)
end

