
-- instantiate all library classes
Class = require 'lib/class'
push = require 'lib/push'


-- initiates all Source Class

require 'src/constants'
require 'src/StateMachines'
require 'src/Animation'


-- assets

require 'src/Util'
require 'src/Character'
require 'src/Platform'


-- initiates all State classes
require 'src/states/BaseState'
require 'src/states/PlayState'
require 'src/states/MenuState'
require 'src/states/OptionState'
require 'src/states/CreditState'
require 'src/states/OverState'
require 'src/states/PauseState'
require 'src/states/ScoreState'

-- global table for all the fonts that will be used
gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['huge'] = love.graphics.newFont('fonts/font.ttf', 32)
}

-- global table for all the backgrounds that will be used
gBackgrounds = {
    ['city'] = love.graphics.newImage('backgrounds/city_bg.png'),
    ['sky'] = love.graphics.newImage('backgrounds/sky_bg.png'),
    ['space'] = love.graphics.newImage('backgrounds/space_bg.png'),
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
    ['hscore'] = love.graphics.newImage('graphics/Title/hscore.png'),
    ['music'] = love.graphics.newImage('graphics/Title/music.png'),
    ['pscore'] = love.graphics.newImage('graphics/Title/pscore.png'),
    ['sound'] = love.graphics.newImage('graphics/Title/sound.png'),
    ['gover'] = love.graphics.newImage('graphics/Title/gover.png'),

    ['platforms'] = love.graphics.newImage('graphics/Platform/Platform_Sheet.png'),
    ['character'] = love.graphics.newImage('graphics/Character/boyJump.png'),

    ['hstable'] = love.graphics.newImage('graphics/hstable.png')
}


gFrames = {
    ['boy'] = GenerateQuads(gTextures['character'], 63, 44),
    ['platforms'] = GenerateQuads(gTextures['platforms'], 16, 48)
}


-- global table for all the Sound EFfects/Music that will be used
gSounds = {
    ['bgMenu'] = love.audio.newSource('bgmusics/menubg.mp3', 'static'),
    ['bgCity'] = love.audio.newSource('bgmusics/citybg.mp3', 'static'),
    ['bgSpace'] = love.audio.newSource('bgmusics/spacebg.mp3', 'static')
}
