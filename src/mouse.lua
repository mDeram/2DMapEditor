local mouse = {}
mouse.currentColor = 1
mouse.fillColor = mouse.currentColor

function mouse.update()
  mouse.x = love.mouse.getX()
  mouse.y = love.mouse.getY()
  if mouse.y <= hud.topBar.height then
    mouse.zone = "topBar"
  elseif mouse.x <= hud.leftBar.width then
    mouse.zone = "leftBar"
  elseif mouse.x >= window.width-hud.rightBar.width then
    mouse.zone = "rightBar"
  else
    mouse.zone = "grid"
    local mx, my = camera:mousePosition()
    mouse.c = math.floor(mx/(grid.tileWidth))+1
    mouse.l = math.floor(my/(grid.tileHeight))+1
  end
end

function mouse.collide(pX, pY, pWidth, pHeight)
  if mouse.x >= pX and mouse.x <= pX+pWidth and mouse.y >= pY and mouse.y <= pY+pHeight then
    return true
  else
    return false
  end
end

return mouse
