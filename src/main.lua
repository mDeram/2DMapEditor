io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end
utf8 = require("utf8")
local major, minor = love.getVersion( )
if minor == 9 then
  mouseTouch1 = "l"
  mouseTouch2 = "r"
else
  mouseTouch1 = 1
  mouseTouch2 = 2
end

window = {}
window.width = 1200
window.height = 700
Font = love.graphics.newFont(16)

data = require("data")
camera = require("camera")
action = require("action")
tool = require("tool")
tile = require("tile")
mouse = require("mouse")
grid = require("grid")
hud = require("hud")
export = require("export")
import = require("import")
input = require("input")



function love.load()
  
  love.window.setMode(1200, 700)
  
  data.load()
  grid.load()
  
  window.grid = {}
  window.grid.width = window.width-hud.leftBar.width-hud.rightBar.width
  window.grid.height = window.height-hud.topBar.height
  
  action.resetPos.f()
  
end

function love.mousepressed(x, y, touch)
  
  action.mousepressed(touch)
  import.mousepressed(touch)
  export.mousepressed(touch)
  input.mousepressed(touch)
  
end

function love.textinput(t)
  input.textinput(t)
end

function love.keypressed(key)
  input.keypressed(key)
end

function love.update(dt)
  
  mouse.update()
  action.update()
  tool.update()
  tile.update()
  
end


function love.draw()
  
  love.graphics.setBackgroundColor(50, 50, 50)
  
  camera:set()
    grid.draw()
    action.grid.f()
  camera:unset()
  
  hud.leftBar.draw()
  hud.rightBar.draw()
  hud.topBar.draw()
  
  hud.drawButtonRightBar(5, 50, 10, 30, tool.list)
  hud.drawButtonRightBar(5, 400, 10, 30, action.list)
  hud.drawButtonRightBar(5, 650, 10, 30, action.importantList)
  hud.drawButtonTopBar(300, 5, 10, 30, export.list, "Export")
  hud.drawButtonTopBar(550, 5, 10, 30, import.list, "Import")
  hud.drawTile(10, 100, 1, 48)
  input.draw()
  
end