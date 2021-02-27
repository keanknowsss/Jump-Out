
-- instantiate all library classes
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

-- initiates all Source Class

require 'src/constants'
require 'src/StateMachines'
require 'src/Animation'


-- assets

require 'src/Util'
require 'src/Character'
require 'src/Platform'
require 'src/Enemy'


-- powerups
require 'src/Spring'
require 'src/Shield'



-- initiates all State classes
require 'src/states/BaseState'
require 'src/states/PlayState'
require 'src/states/MenuState'
require 'src/states/OptionState'
require 'src/states/CreditState'
require 'src/states/OverState'
require 'src/states/PauseState'
require 'src/states/ScoreState'
require 'src/states/GOverState'

-- global table for all the fonts that will be used
gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 10),
    ['score'] = love.graphics.newFont('fonts/font1.ttf', 6),
    ['huge'] = love.graphics.newFont('fonts/title.ttf', 32)
}

-- global table for all the backgrounds that will be used
gBackgrounds = {
    [1] = love.graphics.newImage('backgrounds/city_bg.png'), -- city
    [2] = love.graphics.newImage('backgrounds/sky_bg.png'), -- sky
    [3] = love.graphics.newImage('backgrounds/space_bg.png'), -- space
    ['menubg'] = love.graphics.newImage('backgrounds/city_menu.png')
    
}

-- global table for all the buttons that will be used
gButtons = {
    ['playb'] = love.graphics.newImage('buttons/play.png'),
    ['again'] = love.graphics.newImage('buttons/again.png'),
    ['back'] = love.graphics.newImage('buttons/back.png'),
    ['creditb'] = love.graphics.newImage('buttons/credit.png'),
    ['exit'] = love.graphics.newImage('buttons/exit.png'),
    ['menub'] = love.graphics.newImage('buttons/menu.png'),
    ['on'] = love.graphics.newImage('buttons/on.png'),
    ['off'] = love.graphics.newImage('buttons/off.png'),
    ['optionb'] = love.graphics.newImage('buttons/option.png'),
    ['pauseb'] = love.graphics.newImage('buttons/pause.png'),
    ['resume'] = love.graphics.newImage('buttons/resume.png'),
    ['scoreb'] = love.graphics.newImage('buttons/score.png')

}

gSelect = {
    ['splay'] = love.graphics.newImage('buttons/splay.png'),
    ['sagain'] = love.graphics.newImage('buttons/sagain.png'),
    ['sexit'] = love.graphics.newImage('buttons/sexit.png'),
    ['scredit'] = love.graphics.newImage('buttons/scredit.png'),
    ['sback'] = love.graphics.newImage('buttons/sback.png'),
    ['smenu'] = love.graphics.newImage('buttons/smenu.png'),
    ['soff'] = love.graphics.newImage('buttons/soff.png'),
    ['son'] = love.graphics.newImage('buttons/son.png'),
    ['soption'] = love.graphics.newImage('buttons/soption.png'),
    ['spause'] = love.graphics.newImage('buttons/spause.png'),
    ['sresume'] = love.graphics.newImage('buttons/sresume.png'),
    ['sscore'] = love.graphics.newImage('buttons/sscore.png'),

}

-- all the Textures/Graphics that will be used
gTextures = {
    ['glogo'] = love.graphics.newImage('graphics/gamelab.png'),
    ['jlogo'] = love.graphics.newImage('graphics/logo1.png'),
    ['paused'] = love.graphics.newImage('graphics/Title/paused.png'),
    ['title'] = love.graphics.newImage('graphics/Title/TITLE.png'),
    ['title2'] = love.graphics.newImage('graphics/Title/TITLE2.png'),
    ['cscore'] = love.graphics.newImage('graphics/Title/cscore.png'),
    ['dshooting'] = love.graphics.newImage('graphics/Title/dshooting.png'),
    ['name'] = love.graphics.newImage('graphics/Title/name.png'),
    ['hscore'] = love.graphics.newImage('graphics/Title/hscore.png'),
    ['music'] = love.graphics.newImage('graphics/Title/music.png'),
    ['pscore'] = love.graphics.newImage('graphics/Title/pscore.png'),
    ['sound'] = love.graphics.newImage('graphics/Title/sound.png'),
    ['gover'] = love.graphics.newImage('graphics/Title/gover.png'),

    ['platforms'] = love.graphics.newImage('graphics/Platform/Platform_Sheet.png'),
    ['character'] = love.graphics.newImage('graphics/Character/boyJump.png'),
    ['character-gun'] = love.graphics.newImage('graphics/Character/boyshoot1-Sheet.png'),


    ['ship'] = love.graphics.newImage('graphics/Enemy/spaceship_enemy.png'),    -- ship
    ['enemy1'] = love.graphics.newImage('graphics/Enemy/Enemy(Aliens Big).png'),    -- alien 1
    ['enemy2'] = love.graphics.newImage('graphics/Enemy/Enemy(Aliens Big1).png'),   -- alien 2
    ['enemy3'] = love.graphics.newImage('graphics/Enemy/Enemy(Aliens Small).png'), -- alien 3
    ['enemy4'] = love.graphics.newImage('graphics/Enemy/Enemy(Jet Small).png'), -- alien 4    


    ['spring'] = love.graphics.newImage('graphics/Powerup/Powerup(Spring)).png'),
    ['jetpack'] = love.graphics.newImage('graphics/Powerup/Jetpack(Powerup).png'),
    ['rocket'] = love.graphics.newImage('graphics/Powerup/rocket_powerup.png'),
    ['bubble'] = love.graphics.newImage('graphics/Powerup/shield bubble.png'),
    ['shield'] = love.graphics.newImage('graphics/Powerup/shield.png'),



    ['hstable'] = love.graphics.newImage('graphics/hstable.png')
}


gFrames = {
    ['boy'] = GenerateQuads(gTextures['character'], 63, 44),
    ['shoot'] = GenerateQuads(gTextures['character-gun'], 63, 44),
    ['platforms'] = GenerateQuads(gTextures['platforms'], 16, 48),
    ['enemy1'] = GenerateQuads(gTextures['enemy1'], 32, 32),
    ['enemy2'] = GenerateQuads(gTextures['enemy2'], 32, 32),
    ['enemy3'] = GenerateQuads(gTextures['enemy3'], 20, 32),
    ['enemy4'] = GenerateQuads(gTextures['enemy4'], 16, 32),

    ['spring'] = table.slice(GenerateQuads(gTextures['spring'], 16, 16), 15)
}




-- global table for all the Sound EFfects/Music that will be used
gSounds = {
    ['bgMenu'] = love.audio.newSource('bgmusics/menubg.mp3', 'static'),
    ['bgCity'] = love.audio.newSource('bgmusics/citybg.mp3', 'static'),
    ['bgSpace'] = love.audio.newSource('bgmusics/spacebg.mp3', 'static')
}
