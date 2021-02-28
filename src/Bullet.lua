Bullet = Class{}


function Bullet:init(x, y, bullet)
    self.x, self.y = x, y

    self.height = 16
    self.width = 16

    
    self.remove = false

    self.bulletDirection = bullet

    self.dy = -300

    if self.bulletDirection == 'left' then
        self.x = self.x - 10
        self.dx = math.random(-40,-30)
    else
        self.dx = math.random(30, 40)
    end

end



function Bullet:update(dt)
    
    if self.y < 0 then
        self.remove = true
    else
        self.y = self.y + self.dy * dt
        self.x = self.x + self.dx * dt
    end
end



function Bullet:render()
    love.graphics.draw(gTextures['bullet'], self.x, self.y, 0, 0.5, 0.5)
end



function Bullet:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
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