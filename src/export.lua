local export = {}
export.list = {"exportLua", "exportTxt", "exportJson"}
export.path = "map/map"

function export.txt()
  Folder = io.open(export.path..".txt", "w+")
  io.input(Folder)
    local i
    for i = 1, #grid.map-1 do
      Folder:write(tostring(table.concat(grid.map[i], ","))..",\n")
    end
    Folder:write(tostring(table.concat(grid.map[#grid.map], ","))..",")
  io.close(Folder)
end

function export.lua()
  Folder = io.open(export.path..".lua", "w+")
  io.input(Folder)
    Folder:write("{\n")
    local i
    for i = 1, #grid.map-1 do
      Folder:write("  {"..tostring(table.concat(grid.map[i], ", ")).."},\n")
    end
    Folder:write("  {"..tostring(table.concat(grid.map[#grid.map], ", ")).."}\n}")
  io.close(Folder)
end

function export.json()
  Folder = io.open(export.path..".json", "w+")
  io.input(Folder)
    Folder:write("{\n\"map\" : [["..tostring(table.concat(grid.map[1], ", ")).."],\n")
    local i
    for i = 2, #grid.map-1 do
      Folder:write("          ["..tostring(table.concat(grid.map[i], ", ")).."],\n")
    end
    Folder:write("          ["..tostring(table.concat(grid.map[#grid.map], ", ")).."]]\n}")
  io.close(Folder)
end


function export.mousepressed(touch)
  if mouse.zone == "topBar" then
    local spacing = 10
    local pX = 300
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