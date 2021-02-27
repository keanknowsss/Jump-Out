Platform = Class{}

--[[]
    WILL CHANGE THE TYPE OF PLATFORM BASED ON SCORE AND CURRENT BG:     

    NORMAL PLATFORM: 
    Grass - 1
    Rock - 5
    Asteroid - 7

    DESTRUCTABLE PLATFORM:
    Cloud - 4

    MOVING PLATFORM:
    Plane - 2,3
    Rock Rocket - 6
    Rocket - 8

--]]

function Platform:init(x, y, platform, dy, powerup)

    self.x = x
    self.y = y

    self.scaleY = 2

    -- to be used for the platforms for random looks
    self.scaleX = 2

    self.width = 96
    self.height = 16

    self.platform = platform

    self.dy = dy or 100


    -- randomizes the spawning of the spring
    if self:chanceSpring() then
        self.spring = Spring(math.random(self.x, self.x + self.width - 16), self.y - 20)
        self.spring.dy = self.dy
    else
        self.spring = nil
    end

    
    -- moving platforms is given a dx value
    if self.platform == 2 then
        self.dx = 100
    elseif self.platform == 3 then
        self.dx = -100

    -- last platform is being inverted in some cases
    elseif self.platform == 8 then
        self.dx = -80
        self.scaleX = math.random(2) == 1 and -2 or 2
        self.height = 12
        if self.scaleX < 0 then

            -- self.width = self.width 
            
            self.dx = 80
        end
    end

    self.scored = true

    self.remove = false
end


function Platform:update(dt)

    -- removes the platforms if below the screen
    -- moves it if it is not yet removed
    if self.y > VIRTUAL_HEIGHT + 16 then
        self.remove = true
    else
        self.y = self.y + self.dy * dt
        if self.spring then
            self.spring:downMove(dt)
        end
    end

    if self.spring then
        self.spring:update(dt)        
    end
end




function Platform:render()

    love.graphics.draw(gTextures['platforms'], gFrames['platforms'][self.platform], 
    self.x, -- x
    self.y, -- y
    0, -- orientation
    self.scaleX, -- scaleX
    self.scaleY -- scaleY
)

    if self.spring then
        self.spring:render()
    end

end


-- for the horizontal movement of the platform
function Platform:horizontalMove(dt)
    if self.platform == 3 or (self.platform == 8 and self.scaleX == 2) then
        self.x = math.max(-self.width, self.x + self.dx * dt)
        if self.x == -self.width then
            self.x = VIRTUAL_WIDTH + self.width
        end
    elseif self.platform == 2 or (self.platform == 8 and self.scaleX == -2) then
        self.x = math.min(VIRTUAL_WIDTH + self.width, self.x + self.dx * dt)
        if self.x == VIRTUAL_WIDTH + self.width then
            self.x = -self.width
        end
    else return
    end
end


-- 1 in 5 chance function
function Platform:chanceSpring()
    local in1 = math.random(5)

    if in1 == 1 then
        return true
    end

    return false
end

