local input = {}

input.l = {}
input.l.value = tostring(grid.height)
input.l.focus = false
input.l.x = 0
input.l.y = 0
input.l.width = 30
input.l.height = 30


function input.mousepressed(touch)
  if mouse.collide(input.l.x, input.l.y, input.l.width, input.l.height) then
    input.l.focus = true
  else
    input.l.value = tostring(grid.height)
    input.l.focus = false
  end
end
function input.textinput(t)
  if input.l.focus == true then
    if string.len(input.l.value) < 4 and tonumber(t) ~= nil then
      input.l.value = input.l.value..t
    end
  end
end

function input.keypressed(key)
  if key == "backspace" and input.l.focus then
    input.l.value = string.gsub(input.l.value, ".$", "")
  end
  if key == "return" then
    if string.len(input.l.value) > 0 then
      grid.height = tonumber(input.l.value)
      grid.mapLoad()
    else
      input.l.value = tostring(grid.height)
    end
    input.l.focus = false
  end
end
 
function input.draw()
  love.graphics.print(input.l.value, 0, 0)
end

return input