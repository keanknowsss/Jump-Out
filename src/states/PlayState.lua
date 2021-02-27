

PlayState = Class{__includes = BaseState}

function PlayState:init()
    -- instantiate the character
    self.character = Character()

    -- type of platform to be rendered
    self.platformType = 1

    self.dead = false

    -- creates a table for all the platforms to be generated
    self.platforms = {}
    self.enemy = {}


    -- holds all the scores
    self.score = 0 


    -- self.spring = {}
    self.springPowerup = false


    -- variables for the background scrolling
    self.bgScrollY = -2157
    self.bgScroller = 10
    self.bgCounter = 1

    -- spacing for the platform
    self.spacing = -40

    -- the variables are shifted due to the inverse scaling
    self.character.x = math.floor(self.character.x) + self.character.width


    -- initialized random coordinates for the platforms
    self.platformlastX = math.random(VIRTUAL_WIDTH - 96)
    self.platformY = math.random(VIRTUAL_HEIGHT - 30, VIRTUAL_HEIGHT - 50)

    -- creates the introduction level
    self:initializePlatforms()


    -- bg music
    love.audio.stop()
    gSounds['bgCity']:setLooping(true)
    gSounds['bgCity']:setVolume(MASTER_VOLUME)
    gSounds['bgCity']:play()


end



function PlayState:update(dt)

    -- PAUSE FEATURE
    -- for debug 
    if love.paused then
        if love.keyboard.wasPressed('p') then
            love.paused = false
        else
            return
        end
    else
        if love.keyboard.wasPressed('p') then
            love.paused = true
        end
    end
    
    self.character:update(dt)

    -- ENEMY SPAWN
    if self.score >= 1500 and self:chance() then
        self.createEnemy = true
        self:spawnEnemy()
    end

    -- ENEMY DEATH
    -- triggers the death for the enemy when stepped on by the character
    if self.enemy then
        for k, enemy in pairs(self.enemy) do

            if enemy.death then
                self.dy = 100
                enemy:executeDeath(dt)
            end

            if self.character.dy > 0 then
                if enemy.enemy == 4 then
                    if self.character:collidesJet(enemy) then
                        enemy.death = true
                        self.character.dy = 0
                        self.character.y = enemy.y - 65 + self.character.height + 10
                    end
                else
                    if self.character:collides(enemy) then
                        enemy.death = true
                        self.character.dy = 0
                        self.character.y = enemy.y - 65 + self.character.height + 10
                    end
                end
            end
        end
    end


    -- spring update
    -- and if not active return back to previous variables    
    if self.springPowerup then
        for k, platform in pairs(self.platforms) do
            if platform.spring then
                if not platform.spring.currentAnimation:getCurrentFrame() == 3 then
                    platform.spring:update(dt)
                end
            end
        end

        if self.character.dy > 0 then
            self.springPowerup = false
            self.character.jumpSpeed = -205
            self.bgScroller = 60


            for k, platform in pairs(self.platforms) do
                if platform.spring then
                    platform.spring.dy = 100
                    platform.spring.currentAnimation = platform.spring.idleAnimation    
                end
                platform.dy = 100
            end
        end


    end




    -- changes in characters dy
    -- movement for the platforms, and bg music

    -- if platforms is not nil then this will be activated
    if self.platforms then
        -- only update the platforms when the character is less 
        -- than the half of virtual width


        for k, platforms in pairs(self.platforms) do
            -- when the character is falling down
            -- collision is called
            if self.character.dy > 0 then
                if platforms.spring then
                    -- modifiesall variables
                    if self.character:collidesPowerup(platforms.spring) then
                        self.springPowerup = true             
                        self.character.dy = 0
                        self.character.y = platforms.spring.y - 65 + self.character.height + 5
                        self.character.jumpSpeed = -300
                        platforms.spring.currentAnimation = platforms.spring.activatedAnimation
    
                        for h, platformDy in pairs(self.platforms) do
                            platformDy.dy = 300

                            if platformDy.spring then
                                platformDy.spring.dy = 300 
                            end
                        end
                        self.bgScroller = 100
                    end
                end

                -- collide function is different here because the shape was inverted
                if platforms.platform == 8 and platforms.scaleX < 0 then
                    if self.character:collidesInvertPlat(platforms) then
                        if self.character.y > platforms.y - 65 + self.character.height  then
                            self.character.dy = 0
                            self.character.y = platforms.y - 65 + self.character.height + 5
                        end
                    end

                -- for the rest of the platforms
                else
                    if self.character:collidesPlatform(platforms) then
                    -- changes the y postition and variable when collided with a block
                        if self.character.y > platforms.y - 65 + self.character.height  then
                            self.character.dy = 0
                            self.character.y = platforms.y - 65 + self.character.height + 5

                        -- inplay flag to confirm that if the player fell
                        -- the game ends
                        self.character.inPlay = true
                    end

                end
                end 


            end

            -- only updates the platform and background when the character is above the half of the screen width
            if self.character.y < VIRTUAL_HEIGHT / 2 + 20 then
                platforms:update(dt)
                
                self.bgScrollY = math.min(0, self.bgScrollY + self.bgScroller * dt)
                if self.enemy then
                    for k, enemy in pairs(self.enemy) do
                        enemy:update(dt)
                    end
                end
            end


            platforms:horizontalMove(dt)
        end
    
        
    -- DELETION OF ENTITIES
        
        -- deletes the platform if it moves below the screen 
        -- to avoid clutters from the memory
        for k, platforms in pairs(self.platforms) do
            if platforms.remove then
                table.remove(self.platforms, k)
                self.score = self.score + 100 + math.random(49)
            end
        end

    end

    -- removes the enemy
    if self.enemy then
        for k, enemy in pairs(self.enemy) do
            if enemy.remove then
                table.remove(self.enemy, k)
            end
        end
    end





    -- temporary scoring at the beginning of the game
    if self.score < 500 then
        self.score = math.floor(self.score + self.character.score1 / 3)
    end



    -- death flag 
    -- shift the background
    -- producing a continously falling player
    if not self.dead then
        if self.character.y > VIRTUAL_HEIGHT  then 
            self.bgScrollY = math.max(-2157, self.bgScrollY - 200 - VIRTUAL_HEIGHT)
            self:deathVariables(dt)

        elseif self.enemy then
            for k, enemy in pairs(self.enemy) do
                enemy:moveToSide(dt)
                enemy:animation(dt)

                if self.character.dy < 0 then
                    if enemy.enemy == 4 then
                        if self.character:collidesJet(enemy) then
                            self:deathVariables(dt)
                        end
                    else 
                        if self.character:collides(enemy) then
                            self:deathVariables(dt)
                        end
                    end
                end
            end
        end     
    else
        if self.character.y > VIRTUAL_HEIGHT + self.character.height then
            love.audio.stop()
            gSounds['bgMenu']:setLooping(true)
            gSounds['bgMenu']:play()
            gStateMachine:change('menu')
        end   
    end


    -- continously creating new platforms when is less than 6
    if not self.dead then
        if #self.platforms < 6 then--self.difficultyPLATFORMS then
            self:createNewPlatforms()        
        end
    end


    -- Codes for the background scrolling
    if self.bgScrollY == 0 then
        if self.bgCounter == 3 then
            self.bgScrollY = -1850
        else
            self.bgCounter = math.min(3, self.bgCounter + 1)
            self.bgScrollY =  -2157
        end
    end


    if love.keyboard.wasPressed('escape') then
        love.audio.stop()
        gSounds['bgMenu']:setLooping(true)
        gSounds['bgMenu']:play()
        gStateMachine:change('menu')
    end

    -- pauses the game
    if Button_click(390,5,25,8) and  love.mouse.wasPressed(1) then
        gStateMachine:change('pause')
    end

end




function PlayState:render()

    -- background
    if self.bgScrollY == -VIRTUAL_HEIGHT then
        love.graphics.draw(gBackgrounds[self.bgCounter], 0, self.bgScrollY)
    end


    love.graphics.draw(gBackgrounds[self.bgCounter], 0, self.bgScrollY)




    -- will render if the table is not empty
    if self.platforms then
        for k, platforms in pairs(self.platforms) do
            platforms:render()
        end
    end


    if self.enemy then
        for k, enemy in pairs(self.enemy) do
            enemy:render()
        end
    end


    -- player
    self.character:render()

    

    love.graphics.draw(gTextures['pscore'],5,15)
    love.graphics.print(tostring(self.score), 55, 20)

    Button_draw(18)
    if Button_click(390,5,25,8) then
        love.graphics.draw(gSelect['spause'], 389,4)
    end



    displayFPS()

end


-- displays FPS to screen
function displayFPS()
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 1, 0, 1)

    love.graphics.print('FPS: '.. tostring(love.timer.getFPS()), 5, 5)
    love.graphics.setColor(1,1,1,1)
end


-- creates the "entry level" for the game
function PlayState:initializePlatforms()

    -- only allows a specific number of platforms to be rendered
    while #self.platforms < 6 do
        -- the gap between each blocks

        -- passes only entry level variables for the platform
        table.insert(self.platforms, Platform(self.platformlastX, self.platformY, 1))

        -- Variables increases 
        self.platformY =  math.max(-5, self.platformY + self.spacing)
        self.platformlastX = math.max(-50, 
            math.min(VIRTUAL_WIDTH - 50, 
                self.platformlastX + (math.random(2) == 1 and math.random(100,150) or math.random(-100,-150))))
    end
end



function PlayState:createNewPlatforms()
    -- dy is being passed for the new variables to keep track of the speed 
    -- when a powerup is picked up
    local tempDy = 100

    self.platformY = 0


    -- randomizes the platform type per background
    if self.bgCounter == 1 then
        self.platformType = 1

        if self:chance2() then
            self.platformType = 5
        end

    elseif self.bgCounter == 2 then
        self.platformType = 1

        if self:chance() then
            self.platformType = 5
        end

        if self:chance2() then
            self.platform = math.random(2) == 1 and 2 or 3
        end

        if self:chance3() then
            self.platform = 4
        end

    else
        self.platformType = 5

        if self:chance2() then
            self.platformType = 6
        end

        if self:chance3() then
            self.platformType = 7
        end

        if self:chance() then
            self.platformType = 8
        end
    end

    -- when spring is activated
    tempDy = self.springPowerup == true and 300 or 100

    self.platformY = math.max(5, self.platformY + self.spacing)--10--math.random(-5, -10)
    self.platformlastX = math.max(-50, 
        math.min(VIRTUAL_WIDTH - 50, 
            self.platformlastX + (math.random(2) == 1 and math.random(100,120) or math.random(-100,-120))))


    -- create new platforms
    table.insert(self.platforms, Platform(self.platformlastX, self.platformY, self.platformType, tempDy))

end


function PlayState:spawnEnemy()
    
    if #self.enemy < 1 then
        table.insert(self.enemy, Enemy(4))
    end

end


function PlayState:chance()
    -- self made chance for a decision making 
    local in1 = math.random(20)
    local in2 = math.random(20)
    if in1 == 1 then
        if in2 == 2 then
            return true
        end
    end

    return false
end


function PlayState:chance2()
    local in1 = math.random(10)
    
    if in1 == 1 then
        return true
    end

    return false
end


function PlayState:chance3()
    local in1 = math.random(20)
    local in2 = math.random(10)
    
    
    if in1 == 1 then
        if in2 == 2 then
            return true
        end
    end

    return false
end


function PlayState:deathVariables(dt)
    self.dead = true
    self.platforms = {}
    self.enemy = {}
    self.character.dy = 100
    self.character.y = -self.character.height + self.character.dy * dt
end