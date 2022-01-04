local export = {}
export.list = {"exportLua", "exportTxt", "exportJson"}
export.format = {"lua", "txt", "json"}
export.baseDirectory = love.filesystem.getSourceBaseDirectory()
export.path = export.baseDirectory.."/map/map"

local function errorExportFileNotFound(file)
  if file ~= nil then return false end

  love.window.showMessageBox(
    "An existing directory is required to save a map",
    "Make sure the 'Map save path' specified in the config file 'editor.txt' is valid",
    "error"
  )

  return true
end

local function writeToFileWithExtension(extension, cb)
  local filename = export.path..extension
  local file = io.open(filename, "w+")

  if errorExportFileNotFound(file) then return end

  cb(file)

  io.close(file)
end

function export.txt(file)
  local i
  for i = 1, #grid.map-1 do
    file:write(tostring(table.concat(grid.map[i], ","))..",\n")
  end
  file:write(tostring(table.concat(grid.map[#grid.map], ","))..",")
end

function export.lua(file)
  file:write("local map = {\n")
  local i
  for i = 1, #grid.map-1 do
    file:write("  {"..tostring(table.concat(grid.map[i], ", ")).."},\n")
  end
  file:write("  {"..tostring(table.concat(grid.map[#grid.map], ", ")).."}\n}\n")
  file:write("return map")
end

function export.json(file)
  file:write("{\n\"map\" : [["..tostring(table.concat(grid.map[1], ", ")).."],\n")
  local i
  for i = 2, #grid.map-1 do
    file:write("          ["..tostring(table.concat(grid.map[i], ", ")).."],\n")
  end
  file:write("          ["..tostring(table.concat(grid.map[#grid.map], ", ")).."]]\n}")
end



function export.mousepressed(touch)
  if mouse.zone == "topBar" then
    local spacing = 10
    local pX = 450
    local pY = 5
    local width = 30
    local i
    for i = 1, #export.format do
      local x = pX+(i-1)*spacing+(i-1)*width
      if mouse.collide(x, pY, width, width) and love.mouse.isDown(mouseTouch1) then
        local format = export.format[i]
        local extension = "."..format
        writeToFileWithExtension(extension, export[format])
      end
    end
  end
end


return export
