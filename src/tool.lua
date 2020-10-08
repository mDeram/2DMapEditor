local tool = {}
tool.last = "camera"
tool.current = "camera"
tool.list     = {"pen", "erase", "fill", "tilePicker", "camera"}
tool.shortcut = {"d",   "e",     "f",    "lalt",       "space"}
tool.select = {}
tool.pen = {}
tool.erase = {}
tool.fill = {}
tool.tileSwapper = {}
tool.tilePicker = {}
tool.camera = {}
tool.camera.shortcutWasDown = false

function tool.update()
  
  --(5, 50, 10, 30, tool.list)
  if mouse.zone == "leftBar" then 
    local spacing = 10
    local pX = 5
    local pY = 50
    local height = 30
    local i
    for i = 1, #tool.list do
      local y = pY+(i-1)*spacing+(i-1)*height
      if mouse.collide(pX, y, height, height) then
        if love.mouse.isDown(mouseTouch1) then
          tool.current = tool.list[i]
        end
      end
    end
  end
  
  for i = 1, #tool.shortcut do
    if love.keyboard.isDown(tool.shortcut[i]) then
      if tool.current ~= tool.list[i] then
        tool.last = tool.current
      end
      tool.current = tool.list[i]
    end
  end
  
  if love.mouse.isDown(mouseTouch2) then -- Color picker
    local value = grid.map[mouse.l][mouse.c]
    if tool.current ~= "fill" then
      if value == 0 then
        tool.current = "erase"
      else
        mouse.currentColor = value
        tool.current = "pen"
      end
    else
      mouse.fillColor = value
    end
  end
  
  if mouse.zone == "grid" then
    tool[tool.current].f()
  end
end

function tool.pen.f()
  if love.mouse.isDown(mouseTouch1) then
    if grid.map[mouse.l] ~= nil and grid.map[mouse.l][mouse.c] ~= nil then
      grid.map[mouse.l][mouse.c] = mouse.currentColor
    end
  end
  mouse.fillColor = mouse.currentColor
end

function tool.erase.f()
  if love.mouse.isDown(mouseTouch1) then
    if grid.map[mouse.l] ~= nil and grid.map[mouse.l][mouse.c] ~= nil then
      grid.map[mouse.l][mouse.c] = 0
    end
  end
end

function tool.fill.f()
  if love.mouse.isDown(mouseTouch1) then
    if grid.map[mouse.l] ~= nil and grid.map[mouse.l][mouse.c] ~= nil and grid.map[mouse.l][mouse.c] ~= mouse.fillColor then
      local remplacer = grid.map[mouse.l][mouse.c]
      grid.map[mouse.l][mouse.c] = -1
      
      local i = 1
      local stop = false
      while not stop do
        stop = true
        local l
        for l = 1, grid.height do
          local c
          for c = 1, grid.width do
            local value = grid.map[l][c]
            if value == -1 then
              if grid.map[l] ~= nil and grid.map[l][c-1] ~= nil then
                if grid.map[l][c-1] == remplacer then
                  grid.map[l][c-1] = -1
                  stop = false
                end
              end
              if grid.map[l] ~= nil and grid.map[l][c+1] ~= nil then
                if grid.map[l][c+1] == remplacer then
                  grid.map[l][c+1] = -1
                  stop = false
                end
              end
              if grid.map[l-1] ~= nil and grid.map[l-1][c] ~= nil then
                if grid.map[l-1][c] == remplacer then
                  grid.map[l-1][c] = -1
                  stop = false
                end
              end
              if grid.map[l+1] ~= nil and grid.map[l+1][c] ~= nil then
                if grid.map[l+1][c] == remplacer then
                  grid.map[l+1][c] = -1
                  stop = false
                end
              end
            end
          end
        end
      end
      
    end
    
    local l
    for l = 1, grid.height do
      local c
      for c = 1, grid.width do
        local value = grid.map[l][c]
        if value == -1 then
          grid.map[l][c] = mouse.fillColor
        end
      end
    end
    
  end
  if mouse.fillColor ~= 0 then
    mouse.currentColor = mouse.fillColor
  end
end


function tool.tilePicker.f()
  if love.mouse.isDown(mouseTouch1) then
    local value = grid.map[mouse.l][mouse.c]
    if value == 0 then
      tool.current = "erase"
    else
      mouse.currentColor = value
      mouse.fillColor = value
      tool.current = "pen"
    end
  end
end

function tool.camera.f()
  if love.mouse.isDown(mouseTouch1) then
    if tool.camera.state == false then
      tool.camera.x, tool.camera.y = camera:mousePosition()
      tool.camera.scaleX = camera.scaleX
      tool.camera.scaleY = camera.scaleY
      tool.camera.state = true
    end
    if tool.camera.scaleX ~= camera.scaleX or tool.camera.scaleY ~= camera.scaleY then
      tool.camera.x, tool.camera.y = camera:mousePosition()
      tool.camera.scaleX = camera.scaleX
      tool.camera.scaleY = camera.scaleY
    elseif tool.camera.state then
      if love.mouse.isDown(mouseTouch1) then
        mx, my = camera:mousePosition()
        camera:move(tool.camera.x-mx, tool.camera.y-my)
      end
    end
  else
    tool.camera.state = false
  end
  if love.keyboard.isDown(tool.shortcut[5]) then
    tool.camera.shortcutWasDown = true
  elseif tool.camera.shortcutWasDown then
    tool.current = tool.last
    tool.camera.shortcutWasDown = false
  end
end


return tool