local hud = {}
hud.button = require("button")

hud.leftBar = {}
hud.leftBar.width = 40
hud.leftBar.height = window.height

hud.rightBar = {}
hud.rightBar.width = 200
hud.rightBar.height = window.height

hud.topBar = {}
hud.topBar.width = window.width
hud.topBar.height = 40


function hud.leftBar.draw()
  love.graphics.setColor(85/255, 85/255, 85/255)
  love.graphics.rectangle("fill", 0, 0, hud.leftBar.width, hud.leftBar.height)
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("fill", hud.leftBar.width-1, 0, 1, hud.leftBar.height)
end


function hud.rightBar.draw()
  love.graphics.setColor(85/255, 85/255, 85/255)
  love.graphics.rectangle("fill", window.width-hud.rightBar.width, 0, hud.rightBar.width, hud.rightBar.height)
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("fill", window.width-hud.rightBar.width, 0, 1, hud.rightBar.height)
end


function hud.topBar.draw()
  love.graphics.setColor(85/255, 85/255, 85/255)
  love.graphics.rectangle("fill", 0, 0, hud.topBar.width, hud.topBar.height)
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("fill", 0, hud.topBar.height-1, hud.topBar.width, 1)
end



function hud.drawButtonLeftBar(pX, pY, spacing, height, name)
  love.graphics.setColor(1, 1, 1)
  local i
  for i = 1, #name do
    local y = pY+(i-1)*spacing+(i-1)*height
    if tool.current == name[i] then
      love.graphics.draw(hud.button.bg.on, pX, y)
    else
      if mouse.collide(pX, y, height, height) then
        if love.mouse.isDown(mouseTouch1) then
          love.graphics.draw(hud.button.bg.on, pX, y)
        else
          love.graphics.draw(hud.button.bg.over, pX, y)
        end
      else
        love.graphics.draw(hud.button.bg.off, pX, y)
      end
    end
    love.graphics.draw(hud.button.list[name[i]], pX, y)
  end
end


function hud.drawButtonTopBar(pX, pY, spacing, width, name, title)
  love.graphics.setColor(1, 1, 1)
  if title ~= nil then
    love.graphics.setFont(Font)
    love.graphics.print(title, pX-Font:getWidth(title)-10, Font:getHeight(title)/2)
  end
  local i
  for i = 1, #name do
    local x = pX+(i-1)*spacing+(i-1)*width
    if mouse.collide(x, pY, width, width) then
      if love.mouse.isDown(mouseTouch1) then
        love.graphics.draw(hud.button.bg.on, x, pY)
      else
        love.graphics.draw(hud.button.bg.over, x, pY)
      end
    else
      love.graphics.draw(hud.button.bg.off, x, pY)
    end
    love.graphics.draw(hud.button.list[name[i]], x, pY)
  end
end


function hud.drawTile(pX, pY, spacing, pTileWidth)
  local width = hud.rightBar.width-pX*2
  local rapport = pTileWidth/grid.tileWidth
  local nbColumn = math.floor((width)/(pTileWidth+spacing))
  local paddingX = window.width-hud.rightBar.width+pX + (width-nbColumn*(pTileWidth+spacing))/2
  local nbLine = math.floor(((pTileWidth+spacing)*#grid.tileTexture)/width) + 1
  love.graphics.setColor(1, 1, 1)
  local l
  for l = 1, nbLine do
    local c
    for c = 1, nbColumn do
      if grid.tileTexture[(nbColumn*(l-1))+c] ~= nil then
        local x = paddingX+(c-1)*(pTileWidth+spacing)
        local y = pY+(l-1)*(pTileWidth+spacing)
        if mouse.currentColor == (nbColumn*(l-1))+c then
          love.graphics.setColor(50/255, 50/255, 50/255)
          love.graphics.rectangle("fill", x-1, y-1, pTileWidth+2, pTileWidth+2)
          love.graphics.setColor(1, 1, 1)
        end
        love.graphics.draw(grid.tileSet, grid.tileTexture[(nbColumn*(l-1))+c], x, y, 0, rapport, rapport)
      end
    end
  end
end

return hud