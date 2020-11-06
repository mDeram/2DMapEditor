local action = {}
action.list = {"grid", "resetPos"}
action.importantList = {"resetMap"}

action.move = {}
action.zoom = {}

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
  action.move.f(dt)
  action.zoom.f()
  action.ctrlZ.f(dt)
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

function action.zoom.f()
  if love.keyboard.isDown("lctrl") and (love.keyboard.isDown("=")
                                     or love.keyboard.isDown("+")) then
    action.zoom.wheelmoved(1)
  end
  if love.keyboard.isDown("lctrl") and love.keyboard.isDown("-")then
    action.zoom.wheelmoved(-1)
  end
end

function action.zoom.wheelmoved(y)
  local zoomSize = 0.14
  if y < 0 then
    camera:scale(1 + zoomSize, 1 + zoomSize)
  elseif y > 0 then
    camera:scale(1 - zoomSize, 1 - zoomSize)
  end
end

function action.move.f(dt)
  local moveSpeed = 10*60*dt
  if love.keyboard.isDown("left") then
    camera:move(-moveSpeed*camera.scaleX, 0)
  end
  if love.keyboard.isDown("right") then
    camera:move(moveSpeed*camera.scaleX, 0)
  end
  if love.keyboard.isDown("up") then
    camera:move(0, -moveSpeed*camera.scaleY)
  end
  if love.keyboard.isDown("down") then
    camera:move(0, moveSpeed*camera.scaleY)
  end
end

function action.ctrlZ.f(dt)
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
      local save = action.ctrlZ.save[#action.ctrlZ.save]
      save.height = grid.height
      save.width = grid.width
      local l
      for l = 1, grid.height do
        save[l] = {}
        local c
        for c = 1, grid.width do
          save[l][c] = grid.map[l][c] 
        end
      end
    end
  else
    action.ctrlZ.save[1] = {}
    local save = action.ctrlZ.save[1]
    save.height = grid.height
    save.width = grid.width
    local l
    for l = 1, grid.height do
      save[l] = {}
      local c
      for c = 1, grid.width do
        save[l][c] = grid.map[l][c] 
      end
    end
  end
  
  --check if ctrl is pressed before z
  if (love.keyboard.isDown("lctrl") and not love.keyboard.isDown("z")) or (love.keyboard.isDown("lctrl") and action.ctrlZ.ctrlPressedBeforeZ) then
    action.ctrlZ.ctrlPressedBeforeZ = true
    action.ctrlZ.touch1 = true
    action.ctrlZ.touch2 = love.keyboard.isDown("z")
  else
    action.ctrlZ.ctrlPressedBeforeZ = false
    action.ctrlZ.touch1 = false
    action.ctrlZ.touch2 = false
  end
  
  if action.ctrlZ.touch1 and action.ctrlZ.touch2 then
    if action.ctrlZ.timer == 0 then
      if #action.ctrlZ.save > 1 then
        table.remove(action.ctrlZ.save, #action.ctrlZ.save)
        local save = action.ctrlZ.save[#action.ctrlZ.save]
        grid.height = save.height
        grid.width = save.width
        grid.mapLoad()
        local l
        for l = 1, grid.height do
          local c
          for c = 1, grid.width do
            grid.map[l][c] = save[l][c]
          end
        end
      end
    end
    if action.ctrlZ.timer >= 40 then
      action.ctrlZ.timer = 0
      action.ctrlZ.hasUsed = true
    else
      if action.ctrlZ.timer >= 6 and action.ctrlZ.hasUsed == true then
        action.ctrlZ.timer = 0
      else
        action.ctrlZ.timer = action.ctrlZ.timer + 60*dt
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
  love.graphics.setColor(180/255, 180/255, 180/255, 100/255)
  if action.grid.state == true then
    for i = 1, grid.height+1 do
      love.graphics.line(0, (i-1)*grid.tileHeight, grid.width*grid.tileWidth,(i-1)*grid.tileHeight)
    end
    for i = 1, grid.width+1 do
      love.graphics.line((i-1)*grid.tileWidth, 0, (i-1)*grid.tileWidth, grid.height*grid.tileHeight)
    end
  else
    love.graphics.line(0, 0, grid.width*grid.tileWidth, 0)
    love.graphics.line(0, grid.height*grid.tileHeight, grid.width*grid.tileWidth,grid.height*grid.tileHeight)
    love.graphics.line(0, 0, 0, grid.height*grid.tileHeight)
    love.graphics.line(grid.width*grid.tileWidth, 0, grid.width*grid.tileWidth, grid.height*grid.tileHeight)
  end
end

return action