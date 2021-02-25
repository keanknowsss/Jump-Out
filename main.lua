
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
        ['over'] = function() return OverState() end
    }
    gStateMachine:change('menu')



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
end




function love.update(dt)
    
    if dt > 0.04 then
        return
    end
        
    gStateMachine:update(dt) 

    love.keyboard.keysPressed = {}
    love.mouse.buttons = {}

    
    x1,y1 = love.mouse:getPosition()

        mouseX, mouseY = push:toGame(x1,y1)
end



function love.draw()

    push:apply('start')

        -- love.graphics.clear(40/255, 45/255, 52/255, 255/255)

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
