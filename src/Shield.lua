
Shield = Class{}



function Shield:init(x, y)
    self.x = x
    self.y = y


    self.width = 22
    self.height = 32
    

    self.dy = 100


    self.remove = false
    
end


function Shield:update(dt)

    if self.y > VIRTUAL_HEIGHT + 16 then
        self.remove = true
    else
        self.y = self.y + self.dy * dt
    end
    
end


function Shield:render()
    love.graphics.draw(gTextures['shield'], self.x, self.y, 0, 2, 2)
end


