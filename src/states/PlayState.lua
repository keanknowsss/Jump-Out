



PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.highScores = params.highScores
end

function PlayState:init()
    -- instantiate the character
    self.character = Character()
    
    -- self.jump = true

    self.dead = false

    -- creates a table for all the platforms to be generated
    self.platforms = {}


    -- holds all the scores
    self.score = 0 


    -- variables for the background scrolling
    self.bgScrollY = -2150
    self.bgScroller = 50

    -- the variables are shifted due to the inverse scaling
    self.character.x = math.floor(self.character.x) + self.character.width


    -- initialized random coordinates for the platforms
    self.platformlastX = math.random(VIRTUAL_WIDTH - 96)
    self.platformY = math.random(VIRTUAL_HEIGHT - 30, VIRTUAL_HEIGHT - 50)

    -- creates the introduction level
    self:initializePlatforms()

    love.audio.stop()
    gSounds['bgCity']:setLooping(true)
    gSounds['bgCity']:setVolume(MASTER_VOLUME)
    gSounds['bgCity']:play()

    love.paused = false
end



function PlayState:update(dt)

    -- PAUSE FEATURE
    if love.paused then
        --gSounds['bgCity']:pause()
        if  Button_click(350,100,60,10) and  love.mouse.wasPressed(1) then
            if music then
                gSounds['bgMenu']:stop()
                gSounds['bgCity']:play()
            else
                gSounds['bgCity']:stop()
            end
            love.paused = false
        elseif Button_click(350,150,40,10) and  love.mouse.wasPressed(1) then
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
            gSounds['bgCity']:pause()
            love.paused = true
        end 
    end

    
    if love.keyboard.wasPressed('escape') then
        if music then
            gSounds['bgCity']:stop()
            gSounds['bgMenu']:setLooping(true)
            gSounds['bgMenu']:play()
        else
            gSounds['bgMenu']:stop()
        end
        gStateMachine:change('menu',{highScores = self.highScores})
    end

    if music then
        gSounds['bgMenu']:stop()
        gSounds['bgCity']:play()
    else
        gSounds['bgCity']:stop()
    end


    self.character:update(dt)


    -- if platforms is not nil then this will be activated
    if self.platforms then
        -- only update the platforms when the character is less 
        -- than the half of virtual width


        for k, platforms in pairs(self.platforms) do
            -- when the character is falling down
            -- collision is called
            if self.character.dy > 0 then
                if self.character:collides(platforms) then
                    -- changes the y postition and variable when collided with a block
                    if self.character.y > platforms.y - 65 + self.character.height  then
                        self.character.dy = 0
                        self.character.y = platforms.y - 65 + self.character.height

                        -- inplay flag to confirm that if the player fell
                        -- the game ends
                        self.character.inPlay = true

                        -- temporary scoring
                        if self.scored then
                            self.scored = false
                        else
                            self.scored = true
                        end
                    end
                    
                else
                    self.scored = false
                    
                end        

            end

            -- only updates the platform and background when the character is above the half of the screen width
            if self.character.y < VIRTUAL_HEIGHT / 2  then
                platforms:update(dt)
                self.bgScrollY = math.min(0, self.bgScrollY + self.bgScroller * dt)
            end
            
        end
        



        -- deletes the platform if it moves below the screen 
        -- to avoid clutters from the memory
        for k, platforms in pairs(self.platforms) do
            if platforms.remove then
                self.scored = true
                table.remove(self.platforms, k)
            end
        end

    end

    -- increments the scoring
    if self.scored then
        self.score = self.score +10
    end


    self.character:update(dt)
           

    -- death flag 
    -- shift the background
    -- producing a continously falling player
    if not self.dead then
        if self.character.y > VIRTUAL_HEIGHT  then 
            self.bgScrollY = math.min( 0, self.bgScrollY - 200 - VIRTUAL_HEIGHT * dt)
    
    
            self.dead = true
            self.character.dy = 100
            self.character.y = -self.character.height + self.character.dy * dt
            self.platforms = {}

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

end




function PlayState:render()

    -- background
    love.graphics.draw(gBackgrounds['city'], 0, self.bgScrollY)
    displayFPS()

    -- will render if the table is not empty
    if self.platforms then
        for k, platforms in pairs(self.platforms) do
            platforms:render()
        end
    end

    -- player
    self.character:render()


    love.graphics.draw(gTextures['pscore'],5,15)
    love.graphics.print(tostring(self.score), 55, 20)

    if love.paused then
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
    while #self.platforms < 5 do
        -- the gap between each blocks
        local spacing = math.random(-30,-50)

        -- passes only entry level variables for the platform
        table.insert(self.platforms, Platform(self.platformlastX, self.platformY, 0, 1))

        -- Variables increases 
        self.platformY = math.max(0, self.platformY + spacing)
        self.platformlastX = math.max(-50, 
            math.min(VIRTUAL_WIDTH - 50, 
                self.platformlastX + (math.random(2) == 1 and math.random(100,200) or math.random(-100,-200))))
    end

end


function PlayState:createNewPlatforms()
    self.platformY = -16

    local spacing = math.random(-30,-50)
    
    table.insert(self.platforms, Platform(self.platformlastX, self.platformY, 0, math.random(1)))

    self.platformY = self.platformY + spacing
    self.platformlastX = math.max(-50, 
        math.min(VIRTUAL_WIDTH - 50, 
            self.platformlastX + (math.random(2) == 1 and math.random(100,200) or math.random(-100,-200))))

    
end
