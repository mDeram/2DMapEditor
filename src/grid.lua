local grid = {}
grid.map = {}
grid.width = 50
grid.height = 50
grid.tileWidth = 32
grid.tileHeight = 32
grid.tileTexture = {}
grid.tileSheetPath = "tilesheet/tilesheet2.png"


function grid.load()
  
  grid.tileSheet = love.graphics.newImage(grid.tileSheetPath)
  
  local id = 1
  local nbColumn = grid.tileSheet:getWidth() / grid.tileWidth
  local nbLine = grid.tileSheet:getHeight() / grid.tileHeight
  local l
  for l = 1, nbLine do
    local c
    for c = 1, nbColumn do
      grid.tileTexture[id] = love.graphics.newQuad(
        (c-1)*grid.tileWidth, 
        (l-1)*grid.tileHeight,
        grid.tileWidth,
        grid.tileHeight,
        grid.tileSheet:getWidth(),
        grid.tileSheet:getHeight())
      
      id = id + 1
    end
  end
  
  grid.mapLoad()
  
end

function grid.mapLoad()
  local l
  for l = 1, grid.height do
    grid.map[l] = {}
    local c
    for c = 1, grid.width do
      grid.map[l][c] = 0
    end
  end
end


function grid.draw()
  love.graphics.setColor(255, 255, 255)
  local l
  for l = 1, grid.height do
    local c
    for c = 1, grid.width do
      if grid.map[l] ~= nil and grid.map[l][c] ~= 0 then
        local x = (c-1)*grid.tileWidth
        local y = (l-1)*grid.tileHeight
        love.graphics.draw(grid.tileSheet, grid.tileTexture[grid.map[l][c]], x, y)
      end
    end
  end
  
  love.graphics.setColor(180, 180, 180, 100)
  if action.grid.value == true then
    local i
    for i = 1, grid.height+1 do
      love.graphics.line(0, (i-1)*grid.tileHeight, grid.width*grid.tileWidth,(i-1)*grid.tileHeight)
    end
    local i
    for i = 1, grid.width+1 do
      love.graphics.line((i-1)*grid.tileWidth, 0, (i-1)*grid.tileWidth, grid.height*grid.tileHeight)
    end
  else
    love.graphics.line(0, 0, grid.width*grid.tileWidth, 0)
    love.graphics.line(0, grid.height*grid.tileHeight, grid.width*grid.tileWidth,grid.height*grid.tileHeight)
    love.graphics.line( 0, 0, 0, grid.height*grid.tileHeight)
    love.graphics.line(grid.width*grid.tileWidth, 0, grid.width*grid.tileWidth, grid.height*grid.tileHeight)
  end
end


return grid