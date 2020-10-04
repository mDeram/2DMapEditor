local camera = {}
camera.x = 0
camera.y = 0
camera.scaleX = 1
camera.scaleY = 1
camera.rotation = 0


function camera:set()
  love.graphics.push()
  love.graphics.rotate(-self.rotation)
  love.graphics.translate(window.width/2, window.height/2)
  love.graphics.scale(1/self.scaleX, 1/self.scaleY)
  love.graphics.translate(-window.width/2, -window.height/2)
  love.graphics.translate(-self.x, -self.y)
end


function camera:unset()
  love.graphics.pop()
end


function camera:move(dx, dy)
  self.x = self.x + dx
  self.y = self.y + dy
end


function camera:rotate(dr)
  self.rotation = (self.rotation + dr) % math.pi/2
end


function camera:scale(sx, sy)
  if sx == nil then
    self.scaleX = 1
    self.scaleY = 1
  else
    self.scaleX = self.scaleX*sx
    self.scaleY = self.scaleY*(sy or sx)
  end
end


function camera:setPosition(x, y)
  self.x = x
  self.y = y
end


function camera:setScale(sx, sy)
  self.scaleX = sx
  self.scaleY = sy
end


function camera:mousePosition()
  return ((love.mouse.getX() - window.width/2)*self.scaleX) + window.width/2 + self.x, ((love.mouse.getY() - window.height/2)*self.scaleY) + window.height/2 + self.y
end

return camera