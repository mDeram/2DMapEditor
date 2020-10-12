local data = {}

local function formatString(str)
  return string.gsub(string.gsub(str, "\r", ""), "\n", "")
end

function data.load()
  local filename = "editor.txt"
  local contentFile = {}
  local baseDirectory = love.filesystem.getSourceBaseDirectory()
  local i = 0
  for line in io.lines(baseDirectory.."/"..filename) do
    i = i+1
    contentFile[i] = formatString(line)
  end
  export.path = baseDirectory.."/"..contentFile[2]
  import.path = baseDirectory.."/"..contentFile[2]
  
  grid.tileSheetPath = contentFile[4]
  grid.tileWidth = contentFile[6]
  grid.tileHeight = contentFile[8]
  
  grid.width = tonumber(contentFile[10])
  grid.height = tonumber(contentFile[12])
end

return data