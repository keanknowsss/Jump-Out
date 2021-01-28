
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

