local export = {}
export.list = {"exportLua", "exportTxt", "exportJson"}
export.baseDirectory = love.filesystem.getSourceBaseDirectory()
export.path = export.baseDirectory.."/map/map"

function export.txt()
  local file = io.open(export.path..".txt", "w+")
  io.input(file)
    local i
    for i = 1, #grid.map-1 do
      file:write(tostring(table.concat(grid.map[i], ","))..",\n")
    end
    file:write(tostring(table.concat(grid.map[#grid.map], ","))..",")
  io.close(file)
end

function export.lua()
  local file = io.open(export.path..".lua", "w+")
  io.input(file)
    file:write("local map = {\n")
    local i
    for i = 1, #grid.map-1 do
      file:write("  {"..tostring(table.concat(grid.map[i], ", ")).."},\n")
    end
    file:write("  {"..tostring(table.concat(grid.map[#grid.map], ", ")).."}\n}\n")
    file:write("return map")
  io.close(file)
end

function export.json()
  local file = io.open(export.path..".json", "w+")
  io.input(file)
    file:write("{\n\"map\" : [["..tostring(table.concat(grid.map[1], ", ")).."],\n")
    local i
    for i = 2, #grid.map-1 do
      file:write("          ["..tostring(table.concat(grid.map[i], ", ")).."],\n")
    end
    file:write("          ["..tostring(table.concat(grid.map[#grid.map], ", ")).."]]\n}")
  io.close(file)
end


function export.mousepressed(touch)
  if mouse.zone == "topBar" then
    local spacing = 10
    local pX = 450
    local pY = 5
    local width = 30
    local i
    for i = 1, #export.list do
      local x = pX+(i-1)*spacing+(i-1)*width
      if mouse.collide(x, pY, width, width) then
        if love.mouse.isDown(mouseTouch1) then
          if export.list[i] == "exportLua" then
            export.lua()
          elseif export.list[i] == "exportTxt" then
            export.txt()
          elseif export.list[i] == "exportJson" then
            export.json()
          end
        end
      end
    end
  end
end


return export