local action = {}
action.list = {"grid", "resetPos"}
action.importantList = {"resetMap"}

action.arrow = {}

action.grid = {}
action.grid.state = true

action.resetPos = {}

action.ctrlZ = {}
action.ctrlZ.touch1 = false
action.ctrlZ.touch2 = false
action.ctrlZ.timer = 0
action.ctrlZ.hasUsed = false
action.ctrlZ.limit = 200

action.ctrlZ.save = {}

function action.update(dt)
  action.arrow.f()
  action.ctrlZ.f()
end

function action.mousepressed(touch)
  if mouse.zone == "leftBar" then
    local spacing = 10
    local pX = 5
    local pY = 400
    local height = 30
    local i
    for i = 1, #action.list do
      local y = pY+(i-1)*spacing+(i-1)*height
      if mouse.collide(pX, y, height, height) then
        if love.mouse.isDown(mouseTouch1) then
          if action.list[i] == "grid" then
            if action.grid.state == true then action.grid.state = false else action.grid.state = true end
          elseif action.list[i] == "resetPos" then
            action.resetPos.f()
          end
        end
      end
    end
    local y = 650
    if mouse.collide(pX, y, height, height) then
      grid.mapLoad()
    end
  end
  
end

function action.draw()
  action.grid.f()
end

function action.resetPos.f()
  camera:setScale(1, 1)
  local x
  local y
  if grid.width*grid.tileWidth <= window.grid.width then
    x = (window.grid.width-grid.width*grid.tileWidth)/2 + hud.leftBar.width
  else
    x = hud.leftBar.width
  end
  if grid.height*grid.tileHeight <= window.grid.height then
    y = -((window.grid.height-grid.height*grid.tileHeight)/2 + hud.topBar.height)
  else
    y = grid.height*grid.tileHeight - window.height
  end
  camera:setPosition(-x, y)
end

function action.arrow.f()
  if love.keyboard.isDown("down") then
    camera:scale(1.025, 1.025)
  elseif love.keyboard.isDown("up") then
    camera:scale(0.975, 0.975)
  end
  if love.keyboard.isDown("left") and not love.keyboard.isDown("right") then
    camera:move(-10*camera.scaleX, 0)
  elseif love.keyboard.isDown("right") and not love.keyboard.isDown("left") then
    camera:move(10*camera.scaleX, 0)
  end
end

function action.ctrlZ.f()
  if #action.ctrlZ.save > 0 then
    local result = false
    local l
    for l = 1, grid.height do
      local c
      for c = 1, grid.width do
        if grid.map[l] ~= nil and action.ctrlZ.save[#action.ctrlZ.save][l] ~= nil then
          if action.ctrlZ.save[#action.ctrlZ.save][l][c] ~= grid.map[l][c] then
            result = true
            break
          end
        else
          result = true
          break
        end
      end
    end
    if result then
      action.ctrlZ.save[#action.ctrlZ.save+1] = {}
      local l
      for l = 1, grid.height do
        action.ctrlZ.save[#action.ctrlZ.save][l] = {}
        local c
        for c = 1, grid.width do
          action.ctrlZ.save[#action.ctrlZ.save][l][c] = grid.map[l][c] 
        end
      end
    end
  else
    action.ctrlZ.save[1] = {}
    local l
    for l = 1, grid.height do
      action.ctrlZ.save[1][l] = {}
      local c
      for c = 1, grid.width do
        action.ctrlZ.save[1][l][c] = grid.map[l][c] 
      end
    end
  end
  if love.keyboard.isDown("lctrl") then
    action.ctrlZ.touch1 = true
    if love.keyboard.isDown("z") then
      action.ctrlZ.touch2 = true
    else
      action.ctrlZ.touch2 = false
    end
  else
    action.ctrlZ.touch1 = false
    action.ctrlZ.touch2 = false
  end
  
  if action.ctrlZ.touch1 and action.ctrlZ.touch2 then
    if action.ctrlZ.timer == 0 then
      if #action.ctrlZ.save > 1 then
        table.remove(action.ctrlZ.save, #action.ctrlZ.save)
        local l
        for l = 1, grid.height do
          local c
          for c = 1, grid.width do
            grid.map[l][c] = action.ctrlZ.save[#action.ctrlZ.save][l][c]
          end
        end
      end
    end
    if action.ctrlZ.timer >= 50 then
      action.ctrlZ.timer = 0
      action.ctrlZ.hasUsed = true
    else
      if action.ctrlZ.timer >= 5 and action.ctrlZ.hasUsed == true then
        action.ctrlZ.timer = 0
      else
        action.ctrlZ.timer = action.ctrlZ.timer+1
      end
    end
  else
    action.ctrlZ.timer = 0
    action.ctrlZ.hasUsed = false
  end
  if #action.ctrlZ.save > action.ctrlZ.limit+1 then
    table.remove(action.ctrlZ.save, 1)
  end
end

function action.grid.f()
  love.graphics.setColor(180, 180, 180, 100)
  if action.grid.state == true then
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

return action