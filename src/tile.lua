local tile = {}

function tile.update()
  if mouse.zone == "rightBar" then 
    local pX = 10
    local pY = 100
    local spacing = 1
    local pTileWidth = 32
    
    local width = hud.rightBar.width-pX*2
    local rapport = pTileWidth/grid.tileWidth
    local nbColumn = math.floor((width)/(pTileWidth+spacing))
    local paddingX = window.width-hud.rightBar.width+pX + (width-nbColumn*(pTileWidth+spacing))/2
    local nbLine = math.floor(((pTileWidth+spacing)*#grid.tileTexture)/width) + 1
    local l
    for l = 1, nbLine do
      local c
      for c = 1, nbColumn do
        if grid.tileTexture[(nbColumn*(l-1))+c] ~= nil then
          local x = paddingX+(c-1)*(pTileWidth+spacing)
          local y = pY+(l-1)*(pTileWidth+spacing)
          if mouse.collide(x, y, pTileWidth, pTileWidth) then
            if love.mouse.isDown(mouseTouch1) then
              mouse.currentColor = (nbColumn*(l-1))+c
              mouse.fillColor = (nbColumn*(l-1))+c
              if tool.current ~= "fill" then tool.current = "pen" end
            end
          end
        end
      end
    end
  end
end

return tile