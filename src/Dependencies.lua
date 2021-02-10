
-- instantiate all library classes
Class = require 'lib/class'
push = require 'lib/push'


-- initiates all Source Class

require 'src/constants'
require 'src/StateMachines'


-- assets

require 'src/Util'
require 'src/Character'

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



-- all the Textures/Graphics that will be used
gTextures = {
    ['character'] = love.graphics.newImage('graphics/boyJump.png'),
    ['city'] = love.graphics.newImage('backgrounds/city_bg.png'),
    ['sky'] = love.graphics.newImage('backgrounds/sky_bg.png'),
    ['space'] = love.graphics.newImage('backgrounds/space_bg.png'),
    ['glogo'] = love.graphics.newImage('graphics/gamelab.png')
}


gFrames = {
    ['boy'] = table.slice(GenerateQuads(gTextures['character'], 63, 44), 3)
}


-- global table for all the Sound EFfects/Music that will be used
gSounds = {

}
