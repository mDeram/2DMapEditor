local import = {}
import.list = {"importLua", "importTxt", "importJson"}
import.baseDirectory = love.filesystem.getSourceBaseDirectory()
import.path = import.baseDirectory.."/map/map"

function import.txt()
  local filename = export.path..".txt"
  if filename ~= nil then
    grid.map = {}
    for line in io.lines(filename) do
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
end

function import.lua()
  local filename = export.path..".lua"
  if filename ~= nil then
    grid.map = {}
    for line in io.lines(filename) do 
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
end

function import.json()
  local filename = export.path..".json"
  if filename ~= nil then
    grid.map = {}
    for line in io.lines(filename) do 
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
end


function import.mousepressed(touch)
  if mouse.zone == "topBar" then
    local spacing = 10
    local pX = 700
    local pY = 5
    local width = 30
    local i
    for i = 1, #import.list do
      local x = pX+(i-1)*spacing+(i-1)*width
      if mouse.collide(x, pY, width, width) then
        if love.mouse.isDown(mouseTouch1) then
          if import.list[i] == "importLua" then
            import.lua()
          elseif import.list[i] == "importTxt" then
            import.txt()
          elseif import.list[i] == "importJson" then
            import.json()
          end
        end
      end
    end
  end
end

return import