local button = {}
button.bg = {}
button.bgInput = {}
button.list = {}

--Background
button.bg.on = love.graphics.newImage("graph/button/bgButtonOn.png")
button.bg.off = love.graphics.newImage("graph/button/bgButtonOff.png")
button.bg.over = love.graphics.newImage("graph/button/bgButtonOver.png")

button.bgInput.on = love.graphics.newImage("graph/button/bgInputOn.png")
button.bgInput.off = love.graphics.newImage("graph/button/bgInputOff.png")
button.bgInput.over = love.graphics.newImage("graph/button/bgInputOver.png")


--Tool
--button.list["select"] = love.graphics.newImage("graph/button/toolButtonSelect.png")
button.list["pen"] = love.graphics.newImage("graph/button/toolButtonPen.png")
button.list["erase"] = love.graphics.newImage("graph/button/toolButtonErase.png")
button.list["fill"] = love.graphics.newImage("graph/button/toolButtonFill.png")
--button.list["tileSwapper"] = love.graphics.newImage("graph/button/toolButtonTileSwapper.png")
button.list["tilePicker"] = love.graphics.newImage("graph/button/toolButtonTilePicker.png")
button.list["camera"] = love.graphics.newImage("graph/button/toolButtonCamera.png")

--Action
button.list["grid"] = love.graphics.newImage("graph/button/actionButtonGrid.png")
button.list["resetPos"] = love.graphics.newImage("graph/button/actionButtonResetPos.png")
button.list["resetMap"] = love.graphics.newImage("graph/button/actionButtonResetMap.png")

--Import/Export
button.list["exportLua"] = love.graphics.newImage("graph/button/actionButtonExportLua.png")
button.list["exportTxt"] = love.graphics.newImage("graph/button/actionButtonExportTxt.png")
button.list["exportJson"] = love.graphics.newImage("graph/button/actionButtonExportJson.png")
button.list["importLua"] = love.graphics.newImage("graph/button/actionButtonImportLua.png")
button.list["importTxt"] = love.graphics.newImage("graph/button/actionButtonImportTxt.png")
button.list["importJson"] = love.graphics.newImage("graph/button/actionButtonImportJson.png")

return button