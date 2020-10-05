local data = {}

function data.load()
  local filename = "map/data.txt"
  local contentFile = {}
  local i = 0
  if filename ~= nil then
    for line in io.lines(filename) do
      i = i+1
      contentFile[i] = line
    end
  end
  grid.width = tonumber(contentFile[2])
  grid.height = tonumber(contentFile[4])
  grid.tileSheetPath = contentFile[6].."/"..contentFile[8]
  export.path = contentFile[10].."/"..contentFile[12]
  import.path = contentFile[10].."/"..contentFile[12]
end

return data