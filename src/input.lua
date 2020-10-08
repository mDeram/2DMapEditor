local input = {}
input.list = {"c", "l"}

function input.load()
  local x = 80
  input.add(input.list[1], "width", x, 10, input.list[2])
  input.add(input.list[2], "height", x + 150, 10, input.list[1])
end

function input.add(name, toUpdate, x, y, nextTab)
  input[name] = {}
  input[name].toUpdate = toUpdate
  input[name].value = grid[toUpdate]
  input[name].nextTab = nextTab
  input[name].focus = false
  input[name].x = x
  input[name].y = y
  input[name].width = 60
  input[name].height = 20
end

function input.mousepressed(touch)
  local noFocus = true
  for i = 1, #input.list do
    local curInput = input[input.list[i]]
    if mouse.collide(curInput.x, curInput.y, curInput.width, curInput.height) then
      curInput.focus = true
      noFocus = false
    else
      curInput.focus = false
    end
  end
  if noFocus then
    for i = 1, #input.list do
      local curInput = input[input.list[i]]
      curInput.value = grid[curInput.toUpdate]
    end
  end
end

function input.textinput(t)
  for i = 1, #input.list do
    local curInput = input[input.list[i]]
    if curInput.focus == true then
      if string.len(curInput.value) < 4 and tonumber(t) ~= nil then
        curInput.value = curInput.value..t
      end
    end
  end
end

function input.keypressed(key)
  local toUpdate = false
  local nextOnce = false
  for i = 1, #input.list do
    local curInput = input[input.list[i]]
    if key == "backspace" and curInput.focus then
      curInput.value = string.gsub(curInput.value, ".$", "")
    end
    if key == "return" then
      if string.len(curInput.value) > 0 then
        grid[curInput.toUpdate] = tonumber(curInput.value)
        toUpdate = true
      else
        curInput.value = tostring(grid[curInput.toUpdate])
      end
      curInput.focus = false
    end
    if not nextOnce and key == "tab" and curInput.focus then
      nextOnce = true
      curInput.focus = false
      input[curInput.nextTab].focus = true
    end
  end
  if toUpdate then
    grid.mapLoad()
  end
end
 
function input.draw()
  for i = 1, #input.list do
    local curInput = input[input.list[i]]
    local x = curInput.x
    local y = curInput.y
    if curInput.focus then
      love.graphics.draw(hud.button.bgInput.on, x, y)
    else
      if mouse.collide(x, y, curInput.width, curInput.height) then
        if love.mouse.isDown(mouseTouch1) then
          love.graphics.draw(hud.button.bgInput.on, x, y)
        else
          love.graphics.draw(hud.button.bgInput.over, x, y)
        end
      else
        love.graphics.draw(hud.button.bgInput.off, x, y)
      end
    end
    love.graphics.setFont(Font)
    local name = curInput.toUpdate.." :"
    love.graphics.print(name, curInput.x-Font:getWidth(name)-4, Font:getHeight(name)/2)
    love.graphics.print(curInput.value, curInput.x+10, curInput.y+1)
  end
end

return input