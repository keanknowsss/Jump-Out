utf8 = require("utf8")

OverState = Class{__includes = BaseState}

function OverState:enter(params)
    self.highScores = params.highScores
    self.score = params.score
    self.scoreIndex = params.scoreIndex
end

function OverState:init()
    txt = ''
    love.keyboard.setKeyRepeat(true)
end

function OverState:update(dt)
    bgMenuScroll = (bgMenuScroll + bgMenuScroll_Speed * dt) % bgMenuLooping

    if Button_click(40,200,100,10) and  love.mouse.wasPressed(1) then
        gStateMachine:change('play',{highScores = self.highScores})
    elseif Button_click(350,200,40,10) and  love.mouse.wasPressed(1) then
        gStateMachine:change('menu',{highScores = self.highScores})
    elseif Button_click(130,100,140,20) and  love.mouse.wasPressed(1) then
        show = true
    end

    if show == true then
        function love.textinput(t)
            txt = txt..t
        end
    end

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('menu',{highScores = self.highScores})
    elseif love.keyboard.wasPressed('backspace') then
        if show == true then
            byteoffset = utf8.offset(txt, -1)
            if byteoffset then
                txt = string.sub(txt, 1, byteoffset - 1)
            end
        end
    elseif love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        local name = txt
        local score = self.score
        for i = 10, self.scoreIndex, -1 do
            self.highScores[i + 1] = {
                name = self.highScores[i].name,
                score = self.highScores[i].score
            }
        end

        self.highScores[self.scoreIndex].name = name
        self.highScores[self.scoreIndex].score = self.score

        local scoresStr = ''

        for i = 1, 10 do
            scoresStr = scoresStr .. self.highScores[i].name .. '\n'
            scoresStr = scoresStr .. tostring(self.highScores[i].score) .. '\n'
        end

    --change this to a different file name/create a file
        love.filesystem.write('scoretable.lst', scoresStr)
    end

end

function OverState:render()
    love.graphics.draw(gBackgrounds['menubg'], -bgMenuScroll,0)
    Button_draw(14)
    Button_draw(15)
    love.graphics.draw(gTextures['gover'], 10, 10)
    love.graphics.draw(gTextures['cscore'], 130, 60)
    love.graphics.draw(gTextures['name'],130,100)
    love.graphics.draw(gTextures['hscore'], 130, 140)
    
    if Button_click(40,200,100,10) then
        love.graphics.draw(gSelect['sagain'], 39,199)
    elseif Button_click(350,200,40,10) then
        love.graphics.draw(gSelect['smenu'], 349,199)
    end

    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.print(txt, 187,107)
    love.graphics.print(tostring(self.score), 187, 67)
    love.graphics.print(tostring(self.highScores[1].score), 232, 146)
    love.graphics.print('Enter Your Name(7 Letters): \tPress Enter to Confirm!', 69,84)
    love.graphics.setColor(0,0,0,1)
    love.graphics.print('Enter Your Name(7 Letters): \tPress Enter to Confirm!', 70,85)
    

end

