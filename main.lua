


require 'src/Dependencies'


function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    love.window.setTitle('Jump Out')
    
    love.graphics.setFont(gFonts['small'])

    -- global table for all Game States
    gStateMachine = StateMachine {
        ['play'] = function() return PlayState() end
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
        resizable = true
    })


    love.keyboard.keysPressed = {}
end




function love.update(dt)
   gStateMachine:update(dt) 

   love.keyboard.keysPressed = {}
end



function love.draw()

    push:apply('start')

        love.graphics.clear(40/255, 45/255, 52/255, 255/255)

        gStateMachine:render()

        displayFPS()

        

    push:apply('end')
end





function love.resize(w, h)
    push:resize(w, h)    
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



-- displays FPS to screen
function displayFPS()
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 1, 0, 1)

    love.graphics.print('FPS: '.. tostring(love.timer.getFPS()), 5, 5)
end
