
love.graphics.setDefaultFilter('nearest', 'nearest')

require 'src/Dependencies'





function love.load()
    math.randomseed(os.time())

    love.window.setTitle('Jump Out')
    
    love.graphics.setFont(gFonts['small'])
    
    --buttons
    Button_render(190,160,'playb') --1
    Button_render(10,220,'scoreb') --2
    Button_render(380,220,'exit') --3
    Button_render(350,10,'optionb') --4
    Button_render(350,30,'creditb') --5
    Button_render(380,200,'back') --6
    Button_render(300,71,'on') --7
    Button_render(300,101,'on') --8
    Button_render(300,131,'on') --9
    Button_render(350,71,'off') --10
    Button_render(350,101,'off') --11
    Button_render(350,131,'off') --12
    Button_render(350,40,'back') --13
    Button_render(40,200,'again') --14
    Button_render(350,200,'menub') --15
    Button_render(350,100,'resume') --16
    Button_render(350,150,'menub') --17
    Button_render(390,5,'pauseb') --18


    -- global table for all Game States
    gStateMachine = StateMachine {
        ['play'] = function() return PlayState() end,
        ['menu'] = function() return MenuState() end,
        ['option'] = function() return OptionState() end,
        ['pause'] = function() return PauseState() end,
        ['score'] = function() return ScoreState() end,
        ['credit'] = function() return CreditState() end,
        ['over'] = function() return OverState() end,
        ['gover'] = function() return GOverState() end
    }
    gStateMachine:change('menu',{highScores = loadHighScores()})



    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = false
    })
    
    MASTER_VOLUME = 5
    

    gSounds['bgMenu']:setLooping(true)
    gSounds['bgMenu']:setVolume(MASTER_VOLUME)
    gSounds['bgMenu']:play()

    love.keyboard.keysPressed = {}
    love.mouse.buttons = {}
    mouseX = 0
    mouseY = 0
    
    music = true
    direcshooting = true
    sounds = true
end




function love.update(dt)
    
    if dt > 0.04 then
        return
    end
        
    gStateMachine:update(dt) 

    love.keyboard.keysPressed = {}
    love.mouse.buttons = {}

    
    x1,y1 = love.mouse:getPosition()

    if not sounds  then
        gSounds['button']:stop()
        gSounds['jump']:stop()
        gSounds['fall']:stop()

        gSounds['hit']:stop()
        gSounds['alien']:stop()
        gSounds['jet']:stop()

        gSounds['rocket']:stop()
        gSounds['shoot']:stop()
        gSounds['shield']:stop()
        gSounds['spring']:stop()
    end
    
    if not music then
        gSounds['bgCity']:stop()
        gSounds['bgMenu']:stop()
        gSounds['bgSpace']:stop()
    end

        mouseX, mouseY = push:toGame(x1,y1)
end



function love.draw()

    push:apply('start')


    gStateMachine:render()

    push:apply('end')
end


-- functions used to detect keyboard input
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true    
end


-- functions used to detect keyboard input
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    love.mouse.buttons[button] = true
end

function love.mouse.wasPressed(button)
    if love.mouse.buttons[button] then
        return true
    else
        return false
    end
end

Button = {}

function Button_render(x,y,photo)
    table.insert(Button,{x=x,y=y,photo=photo})
end

function Button_draw(i)
    love.graphics.draw(gButtons[Button[i].photo], Button[i].x,Button[i].y)
    
end

function Button_click(x, y, width, height)
    if mouseX >= x and mouseX <= x + width and mouseY >= y and mouseY <= y + height then
        return true
    else
        return false
    end
end

function loadHighScores()
    love.filesystem.setIdentity('scoretable')

    -- if the file info is nil, initialize it with some default scores
    if not love.filesystem.exists('scoretable.lst') then
        local scores = ''
        for i = 10, 1, -1 do
            scores = scores .. 'GameLab\n'
            scores = scores .. tostring(i * 100) .. '\n'
        end

        love.filesystem.write('scoretable.lst', scores)
    end

    -- flag for whether we're reading a name or not
    local name = true
    local currentName = nil
    local counter = 1

    -- initialize scores table with at least 10 blank entries
    local scores = {}

    for i = 1, 10 do
        -- blank table; each will hold a name and a score
        scores[i] = {
            name = nil,
            score = nil
        }
    end

    -- iterate over each line in the file, filling in names and scores
    for line in love.filesystem.lines('scoretable.lst') do
        if name then
            scores[counter].name = string.sub(line,1,7)
        else
            scores[counter].score = tonumber(line)
            counter = counter + 1
        end

        -- flip the name flag
        name = not name
    end

    return scores

    
end

