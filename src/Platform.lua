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

function Platform:init(x, y, dx, platform, scaleX)

    self.x = x
    self.y = y

    self.scaleY = 2

    -- to be used for the platforms for random looks
    self.scaleX = scaleX or 2--or math.random(2) == 1 and 2 or -2

    self.width = 96
    self.height = 16

    self.platform = platform

    self.dy = 200
    self.dx = dx

    self.remove = false
end


function Platform:update(dt)

    -- removes the platforms if below the screen
    -- moves it if it is not yet removed
    if self.y > VIRTUAL_HEIGHT + 16 then
        self.remove = true
    else
        self.y = self.y + self.dy * dt
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
end


