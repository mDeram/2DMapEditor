local import = {}
import.list = {"importLua", "importTxt", "importJson"}
import.format = {"lua", "txt", "json"}
import.baseDirectory = love.filesystem.getSourceBaseDirectory()
import.path = import.baseDirectory.."/map/map"


local function errorImportFileNotFound(file, extension)
  if file ~= nil then return false end

  love.window.showMessageBox(
    "An existing file is required to load a map",
    "Make sure the 'Map save path' specified in the config file 'editor.txt' is valid\nAlso make sure that a file with the extension '"..extension.."' exists",
    "error"
  )

  return true
end

local function readFromFileWithExtension(extension, cb)
  local filename = import.path..extension
  local file = io.open(filename, "r")

  if errorImportFileNotFound(file, extension) then return end

  cb(file)

  io.close(file)
end

function import.txt(file)
  grid.map = {}
  for line in file:lines() do
    contentFolder = line
    contentFolder = string.gsub(contentFolder, " ", "")
    if string.find(contentFolder, ",") ~= nil then
      grid.map[#grid.map+1] = {}
      local regex = "(%d+)%p"
      local j = true
      while j do
        local result = string.match(contentFolder, regex)
        if result ~= nil then
          contentFolder = string.gsub(contentFolder, regex, "", 1)
          grid.map[#grid.map][#grid.map[#grid.map]+1] = tonumber(result)
        else
          j = false
        end
      end
    end
  end
  grid.width = #grid.map[#grid.map]
  grid.height = #grid.map
  action.resetPos.f()
end

function import.lua(file)
  grid.map = {}
  for line in file:lines() do
    contentFolder = line
    contentFolder = string.gsub(contentFolder, " ", "")
    contentFolder = string.gsub(contentFolder, "{", "")
    contentFolder = string.gsub(contentFolder, "^}$", "")
    contentFolder = string.gsub(contentFolder, "}", ",")
    contentFolder = string.gsub(contentFolder, ",,", ",")
    if string.find(contentFolder, ",") ~= nil then
      grid.map[#grid.map+1] = {}
      local regex = "(%d+)%p"
      local j = true
      while j do
        local result = string.match(contentFolder, regex)
        if result ~= nil then
          contentFolder = string.gsub(contentFolder, regex, "", 1)
          grid.map[#grid.map][#grid.map[#grid.map]+1] = tonumber(result)
        else
          j = false
        end
      end
    end
  end
  grid.width = #grid.map[#grid.map]
  grid.height = #grid.map
  action.resetPos.f()
end

function import.json(file)
  grid.map = {}
  for line in file:lines() do
    contentFolder = line
    contentFolder = string.gsub(contentFolder, " ", "")
    contentFolder = string.gsub(contentFolder, "{", "")
    contentFolder = string.gsub(contentFolder, "}", "")
    contentFolder = string.gsub(contentFolder, "%[", "")
    contentFolder = string.gsub(contentFolder, "%]%]", ",")
    contentFolder = string.gsub(contentFolder, "%]", "")
    contentFolder = string.gsub(contentFolder, "\"%a+\"", "")
    contentFolder = string.gsub(contentFolder, ":", "")
    contentFolder = string.gsub(contentFolder, " ", "")
    if string.find(contentFolder, ",") ~= nil then
      grid.map[#grid.map+1] = {}
      local regex = "(%d+)%p"
      local j = true
      while j do
        local result = string.match(contentFolder, regex)
        if result ~= nil then
          contentFolder = string.gsub(contentFolder, regex, "", 1)
          grid.map[#grid.map][#grid.map[#grid.map]+1] = tonumber(result)
        else
          j = false
        end
      end
    end
  end
  grid.width = #grid.map[#grid.map]
  grid.height = #grid.map
  action.resetPos.f()
end



function import.mousepressed(touch)
  if mouse.zone == "topBar" then
    local spacing = 10
    local pX = 700
    local pY = 5
    local width = 30
    local i
    for i = 1, #import.format do
      local x = pX+(i-1)*spacing+(i-1)*width
      if mouse.collide(x, pY, width, width) and love.mouse.isDown(mouseTouch1) then
        local format = import.format[i]
        local extension = "."..format
        readFromFileWithExtension(extension, import[format])
      end
    end
  end
end

return import
