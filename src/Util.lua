
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