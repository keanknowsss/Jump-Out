
love.graphics.setDefaultFilter('nearest', 'nearest')

require 'src/Dependencies'


function love.load()
    math.randomseed(os.time())

    love.window.setTitle('Jump Out')
    
    love.graphics.setFont(gFonts['small'])


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
        resizable = true
    })


    love.keyboard.keysPressed = {}
end




function love.update(dt)
    
    if dt > 0.04 then
        return
    end
        
    gStateMachine:update(dt) 

    love.keyboard.keysPressed = {}
end



function love.draw()

    push:apply('start')

        love.graphics.clear(40/255, 45/255, 52/255, 255/255)

        gStateMachine:render()

        

        

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



