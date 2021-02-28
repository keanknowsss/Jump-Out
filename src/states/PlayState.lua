



PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.highScores = params.highScores
end

function PlayState:init()
    -- instantiate the character
    self.character = Character()
    self.character.inGame = true

    -- type of platform to be rendered
    self.platformType = 1

    self.dead = false

    -- creates a table for all the platforms to be generated
    self.platforms = {}
    self.enemy = {}


    -- holds all the scores
    self.score = 0 


    self.springPowerup = false
    self.shieldPowerup = false
    self.jetpackPowerup = false

    self.playerJetpack = PlayerJetpack(0,0)


    self.bubbleX = 0
    self.bubbleY = 0
    self.bubble = {bubbleOpacity = 180}

    -- variables for the background scrolling
    self.bgScrollY = -2157
    self.bgScroller = 10
    self.bgCounter = 1

    -- spacing for the platform
    self.spacing = -50

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

    love.paused = false
end



function PlayState:update(dt)
    Timer.update(dt)

    -- PAUSE FEATURE
    if love.paused then
        --gSounds['bgCity']:pause()
        if  Button_click(350,100,60,10) and  love.mouse.wasPressed(1) then
            gSounds['button']:play()

            if music then
                gSounds['bgMenu']:stop()
                gSounds['bgCity']:play()
            else
                gSounds['bgCity']:stop()
            end
            love.paused = false
        elseif Button_click(350,150,40,10) and  love.mouse.wasPressed(1) then
            gSounds['button']:play()

            if music then
                gSounds['bgCity']:stop()
                gSounds['bgMenu']:setLooping(true)
                gSounds['bgMenu']:play()
            else
                gSounds['bgMenu']:stop()
            end
            gStateMachine:change('menu',{highScores = self.highScores})
        else
            return
        end
    else
        if Button_click(390,5,25,8) and  love.mouse.wasPressed(1) then
            gSounds['button']:play()
            gSounds['bgCity']:pause()
            love.paused = true
        end 
    end

    
    if love.keyboard.wasPressed('escape') then
            gSounds['button']:play()

            love.audio.stop(gSounds['bgCity'])
            gSounds['bgMenu']:setLooping(true)
            gSounds['bgMenu']:play()
        -- end
        gStateMachine:change('menu',{highScores = self.highScores})
    end




    self.character:update(dt)

    -- ENEMY SPAWN
    if self.score >= 2000 and self:chance20() then
        self.createEnemy = true
        self:spawnEnemy()
    end



    

    --POWERUPS

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
            self.bgScroller = 10
            self.character.speed = 150


            for k, platform in pairs(self.platforms) do
                if platform.spring then
                    platform.spring.dy = 100
                    platform.spring.currentAnimation = platform.spring.idleAnimation    
                end

                if platform.shield then
                    platform.shield.dy = 100
                end
                platform.dy = 100
            end
        end
    end


    for k, platforms in pairs(self.platforms) do
        -- SHIELD
        if platforms.shield then
            if self.character:collidesPowerup2(platforms.shield) then
                if self.shieldPowerup then
                    self.shieldPowerup = true


                else
                    Timer.clear()
                    self.shieldPowerup = true

                    gSounds['shield']:stop()
                    gSounds['shield']:play()

                end

                platforms.shield = nil
            end
        end

        if platforms.jetpack then
            if self.character:collidesPowerup2(platforms.jetpack) then
                if not self.jetpackPowerup then
                    gSounds['rocket']:stop()
                    gSounds['rocket']:play()

                    self.jetpackPowerup = true
                    Timer.clear()
                    self.playerJetpack = PlayerJetpack(self.character.x, self.character.y)
                else


                    self.jetpackPowerup = true
                end
                platforms.jetpack = nil    
            end
        end
    end

    -- BUBBLE COORDINATES -- 
    -- moves with respect to the player
    self.bubbleX = self.character.x - self.character.width - 14
    self.bubbleY = self.character.y - self.character.height - 4


    --TWEEN ANIMATION FOR THE SHIELD
    if self.shieldPowerup then

            Timer.after(3, function()
            Timer.tween(2,
                {[self.bubble] = {bubbleOpacity = 220}
            }):finish(function()
                Timer.tween(3, {
                    [self.bubble] = {bubbleOpacity = 20}
                }):finish(function()
                        self.shieldPowerup = false
                        self.bubble.bubbleOpacity = 180
                end)                
            end)
        end)

    end



    -- JETPACK
    if self.jetpackPowerup then
        gSounds['jump']:stop()
        gSounds['shoot']:stop()

        Timer.after(3, function()
            self.jetpackPowerup = false

            for h, platformDy in pairs(self.platforms) do
                platformDy.dy = 100
    
                if platformDy.spring then
                    platformDy.spring.dy = 100 
                end
    
                if platformDy.shield then
                    platformDy.shield.dy = 100
                end
    
                if platformDy.jetpack then
                    platformDy.jetpack.dy = 100
                end
            end
            self.bgScroller = 10

            self.playerJetpack = nil

        end)
        
        self.playerJetpack:update(dt)
        self.character.x = self.playerJetpack.x 
        self.character.y = self.playerJetpack.y

        
        for h, platformDy in pairs(self.platforms) do
            platformDy.dy = 400

            if platformDy.spring then
                platformDy.spring.dy = 400 
            end

            if platformDy.shield then
                platformDy.shield.dy = 400
            end

            if platformDy.jetpack then
                platformDy.jetpack.dy = 400
            end
        end
        self.bgScroller = 100
    -- else
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
                        gSounds['jump']:stop()
                        gSounds['spring']:stop()
                        gSounds['spring']:play()
                        gSounds['jump']:play()


                        self.springPowerup = true             
                        self.character.dy = 0
                        self.character.y = platforms.spring.y - 65 + self.character.height + 5
                        self.character.jumpSpeed = -300
                        self.character.speed = 300
                        platforms.spring.currentAnimation = platforms.spring.activatedAnimation
    
                        for h, platformDy in pairs(self.platforms) do
                            platformDy.dy = 300

                            if platformDy.spring then
                                platformDy.spring.dy = 300 
                            end

                            if platformDy.shield then
                                platformDy.shield.dy = 300
                            end

                            if platformDy.jetpack then
                                platformDy.jetpack.dy = 300
                            end
                        end
                        self.bgScroller = 60
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

                if self.character.y < VIRTUAL_HEIGHT / 4 then
                    self.bgScroller = 60
                    platforms.dy = 250
                    if platforms.spring then
                        platforms.spring.dy = 250
                    end

                    if platforms.shield then
                        platforms.shield.dy = 250

                    end

                    if platforms.jetpack then
                        platforms.jetpack.dy = 250                    
                    end

                else
                    self.bgScroller = 10
                    platforms.dy = 100
                    if platforms.spring then
                        platforms.spring.dy = 100
                    end

                    if platforms.shield then
                        platforms.shield.dy = 100

                    end

                    if platforms.jetpack then
                        platforms.jetpack.dy = 100                    
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


    -- ENEMY DEATH
    -- triggers the death for the enemy when stepped on by the character
    if self.enemy then
        for k, enemy in pairs(self.enemy) do
            if enemy.enemy == 4 then
                gSounds['jet']:play()
            else
                gSounds['alien']:play()
            end

            if enemy.death then
                self.dy = 100
                enemy:executeDeath(dt)
            end

            if self.character.dy > 0 then
                if enemy.enemy == 4 then
                    if self.character:collidesJet(enemy) then
                        gSounds['hit']:stop()
                        gSounds['hit']:play()

                        gSounds['jump']:stop()
                        gSounds['jump']:play()

                        enemy.death = true
                        self.character.dy = 0
                        self.character.y = enemy.y - 65 + self.character.height + 10
                    end
                else
                    if self.character:collides(enemy) then
                        gSounds['hit']:stop()
                        gSounds['hit']:play()

                        gSounds['jump']:stop()
                        gSounds['jump']:play()

                        enemy.death = true
                        self.character.dy = 0
                        self.character.y = enemy.y - 65 + self.character.height + 10
                    end
                end
            end

            if self.character.bullet then
                for k, bullet in pairs(self.character.bullet) do
                    if bullet:collides(enemy) then
                        gSounds['hit']:stop()
                        gSounds['hit']:play()

                        enemy.death = true
                        enemy.remove = true
                        bullet.remove = true
                    end
                end
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

    if self.character.bullet then
        for k, bullet in pairs(self.character.bullet) do
            if bullet.remove then
                table.remove(self.character.bullet, k)
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
            gSounds['fall']:play()

        elseif self.enemy then
            if not self.jetpackPowerup then
                for k, enemy in pairs(self.enemy) do
                    enemy:moveToSide(dt)
                    enemy:animation(dt)
    
                    if self.character.dy < 0 and not self.shieldPowerup then
                        if enemy.enemy == 4 then
                            if self.character:collidesJet(enemy) then
                                self:deathVariables(dt)
                                gSounds['fall']:play()
                                
                            end
                        else 
                            if self.character:collides(enemy) then
                                self:deathVariables(dt)
                                gSounds['fall']:play()
                            end
                        end
                    end
                end
            end

        end     
    else
        if self.character.y > VIRTUAL_HEIGHT + self.character.height then
            local highScore = false
        
            -- keep track of what high score ours overwrites, if any
            local scoreIndex = 11

            for i = 10, 1, -1 do
                local score = self.highScores[i].score or 0
                if self.score > score then
                    highScoreIndex = i
                    highScore = true
                end
            end

            if highScore then
                if music then
                    gSounds['bgCity']:stop()
                    gSounds['bgMenu']:setLooping(true)
                    gSounds['bgMenu']:play()
                else
                    gSounds['bgMenu']:stop()
                end
            gStateMachine:change('over', {
                highScores = self.highScores,
                score = self.score,
                scoreIndex = highScoreIndex
            }) 
            else 
                gStateMachine:change('gover', {
                    highScores = self.highScores,
                    score = self.score
                }) 
            end   
        end
    end


    -- continously creating new platforms when is less than 6
    if not self.dead then
        if #self.platforms < 6 then
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

    if self.jetpackPowerup then
        self.playerJetpack:render()    
    else
        self.character:render()
    end

    if self.shieldPowerup then
        love.graphics.setColor(1,1,1,self.bubble.bubbleOpacity/255)
        love.graphics.draw(gTextures['bubble'], self.bubbleX, self.bubbleY)
        love.graphics.setColor(1,1,1,1)
    end
    

    love.graphics.draw(gTextures['pscore'],5,15)
    love.graphics.print(tostring(self.score), 55, 20)

    if love.paused then
        love.graphics.setColor(0/255, 0/255, 0/255, 155/255)
        love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
        love.graphics.setColor(1,1,1,1)

        Button_draw(16)
        Button_draw(17)
        love.graphics.draw(gTextures['paused'],130,5)
        love.graphics.draw(gTextures['title2'],60,70)
        love.graphics.draw(gTextures['jlogo'], 68,110)
        if Button_click(350,100,60,10) then
            love.graphics.draw(gSelect['sresume'], 349,99)
        elseif Button_click(350,150,40,10) then
            love.graphics.draw(gSelect['smenu'], 349,149)
        end
    else
        Button_draw(18)
        if Button_click(390,5,25,8) then
            love.graphics.draw(gSelect['spause'], 389,4)
        end
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
        table.insert(self.platforms, Platform(self.platformlastX, self.platformY, 1, 100, math.random(2)))

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

        if self:chance5() then
            self.platformType = 5
        end

    elseif self.bgCounter == 2 then
        self.platformType = 1


        if self:chance5() then
            self.platformType = math.random(2) == 1 and 2 or 3
        

        elseif self:chance5() then
            self.platformType = 4
        end
    else
        self.platformType = 5

        if self:chance10() then
            self.platformType = 6
        

        elseif self:chance5() then
            self.platformType = 7
        

        elseif self:chance8() then
            self.platformType = 8
        end
    end

    -- when spring is activated
    tempDy = self.springPowerup == true and 300 or 100

    self.platformY = math.max(5, self.platformY + self.spacing)
    self.platformlastX = math.max(-50, 
        math.min(VIRTUAL_WIDTH - 50, 
            self.platformlastX + (math.random(2) == 1 and math.random(100,120) or math.random(-100,-120))))


    -- create new platforms
    table.insert(self.platforms, Platform(self.platformlastX, self.platformY,self.platformType, tempDy, math.random(3)))

end


function PlayState:spawnEnemy()
    
    if #self.enemy < 1 then
        table.insert(self.enemy, Enemy(math.random(5)))
    end

end


function PlayState:chance5()
    -- self made chance for a decision making 
    local in1 = math.random(5)

    return in1 == 1
end



function PlayState:chance10()
    local in1 = math.random(10)
    
    return in1 == 1
end


function PlayState:chance8()
    local in1 = math.random(8)
    
    return in1 == 1
end

function PlayState:chance20()
    local in1 = math.random(20)
    local in2 = math.random(20)
    if in1 == 1 then
        if in2 == 2 then
            return true
        end
    end
end


function PlayState:deathVariables(dt)
    self.dead = true
    self.platforms = {}
    self.enemy = {}
    self.character.dy = 100
    self.character.y = -self.character.height + self.character.dy * dt
end


