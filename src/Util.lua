
function GenerateQuads(atlas, tileHeight, tileWidth)

    local sheetHeight = atlas:getHeight() / tileHeight
    local sheetWidth = atlas:getWidth() / tileWidth


    local sheetCounter = 1
    local spritesheet = {}


    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] = love.graphics.newQuad(
                x * tileWidth, y * tileHeight, 
                tileWidth, tileHeight, 
                atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end



function table.slice(tbl, first, last, step)
    local sliced = {}

    for i = first or 1, last or #tbl, step or 1 do
        sliced[#sliced+1] = tbl[i]
    end

    return sliced
end



function GenerateSpriteQuads(atlas)
    
    local spritesheet = {}


    for x = 1, 12, 1 do
        table.insert(spritesheet, love.graphics.newQuad((x-1)*44, 0, 43, 63, atlas:getDimensions()))
    end
    

    for x = 1, 9, 1 do
        table.insert(spritesheet, love.graphics.newQuad((x-1)*44, 63, 43,63, atlas:getDimensions()))
    end


    for x = 1, 5, 1 do
        table.insert(spritesheet, love.graphics.newQuad((x-1)*52, 126, 52, 63, atlas:getDimensions()))
    end

    return spritesheet
end