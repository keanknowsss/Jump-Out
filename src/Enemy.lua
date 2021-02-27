--[[
    ENEMIES WITH ANIMATION

    1. ENEMY 1
    2 ENEMY 2
    3. ENEMY 3
    4. ENEMY 4

    W/O ANIMATION

    5. SHIP

]]--


Enemy = Class{}


function Enemy:init(enemy)

    self.enemy = enemy

    if not self.enemy == 4 then
        self.moveX = math.random(2) == 1 and true or false
    end

    if self.moveX then
        self.goal = math.random(VIRTUAL_WIDTH)
    else
        self.goal = nil
    end

    self.dx = 10
    self.dy = 30

    self.x = 0
    

    
    -- sets the variable for enemy 1 to be used in passing through the playstate
    if self.enemy == 1 then
        self.width = 64
        self.height = 64
        self.texture = gTextures['enemy1']
        self.frame = gFrames['enemy1']

        self.x = math.random(VIRTUAL_WIDTH - self.width)
        self.y = -self.height - 5


        self.idleAnimation = Animation {
            frames = {1, 2, 3, 4, 5, 6},
            interval = 0.1
        }


        self.currentAnimation = self.idleAnimation


    -- sets the variable for enemy 2 to be used in passing through the playstate
    elseif self.enemy == 2 then
        self.width = 64
        self.height = 64
        self.texture = gTextures['enemy2']
        self.frame = gFrames['enemy2']

        self.x = math.random(VIRTUAL_WIDTH - self.width)
        self.y = -self.height - 5


        self.idleAnimation = Animation {
            frames = {1, 2, 3, 4, 5, 6},
            interval = 0.1
        }


        -- self.currentAnimation = self.idleAnimation


    -- sets the variable for enemy 3 to be used in passing through the playstate
    elseif self.enemy == 3 then
        self.width = 64
        self.height = 40
        self.texture = gTextures['enemy3']
        self.frame = gFrames['enemy3']

        self.x = math.random(VIRTUAL_WIDTH - self.width)
        self.y = -self.height - 5


        self.idleAnimation = Animation {
            frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,14, 15},
            interval = 0.05
        }

        -- self.currentAnimation = self.idleAnimation

    -- sets the variable for enemy 4 to be used in passing through the playstate
    elseif self.enemy == 4 then
        self.width = 60
        self.height = 25
        self.dx = 100
        self.texture = gTextures['enemy4']
        self.frame = gFrames['enemy4']

        self.invert = math.random(2) == 1 and -2 or 2

        self.x = VIRTUAL_WIDTH 
        self.goal = -self.width - 20


        self.idleAnimation = Animation {
            frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,14, 15},
            interval = 0.05
        }



    -- sets the variable for enemy 5 to be used in passing through the playstate
    elseif self.enemy == 5 then
        self.width = 54
        self.height = 60        
        
        self.x = math.random(VIRTUAL_WIDTH - self.width)
        self.y = -self.height - 5

        self.texture = gTextures['ship']
    end

    self.currentAnimation = self.idleAnimation

    self.y = 150
    

    self.remove = false
    self.death = false



end



function Enemy:update(dt)

    -- removes an enemy if below the screen
    if self.y > VIRTUAL_HEIGHT + 32 then
        self.remove = true
    else
        if self.enemy == 4 then
            if self.x == self.goal then
                self.y = self.y + self.dy * dt
            end
        else
            self.y = self.y + self.dy * dt

        end
    end


end



function Enemy:render()
    if self.enemy == 5 then
        love.graphics.draw(self.texture, self.x, self.y, 0, 2, 2)
    else
        love.graphics.draw(self.texture, self.frame[self.currentAnimation:getCurrentFrame()], self.x, self.y, 0, 2, 2)
    end
end


-- for the moving enemy
function Enemy:moveToSide(dt)

    if self.enemy == 4 then
        self.x = math.max(self.goal, self.x - self.dx * dt)
    else
        -- moves an enemy horizontally
        if self.goal then
            if self.x > self.goal then
                self.x = math.max(self.goal, self.x - self.dx * dt)

            elseif self.goal > self.x then
                self.x = math.min(self.goal, self.x + self.dx * dt)

            end
        end
    end

end

-- for the animating enemy
function Enemy:animation(dt)
    if self.enemy > 0 and self.enemy < 5 then

        self.currentAnimation:update(dt)
    end
end


-- when the character stepped on the enemy
function Enemy:executeDeath(dt)
    self.y = self.y + self.dy *  3 * dt
    
    if self.y > VIRTUAL_HEIGHT + self.height + 5 then
        self.remove = true
    end
    
end