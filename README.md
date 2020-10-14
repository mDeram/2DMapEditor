# 2DMapEditor

A minimalist 2D map editor.
Create single layer 2D maps from a .png tileset.
Export maps to txt, json, lua format.

## Preview
img

## Features

- Edition:
	- Resize
	- Draw
	- Erase
	- Fill
	- Tile Picker
	- Clear
- Movement:
	- Move
	- Zoom
- Display:
	- Toggle grid
	- Reset
- Import:
	- .txt
	- .json
	- .lua
- Export:
	- .txt
	- .json
	- .lua
- Set settings from editor.txt
- Tiles display as drawing palette

---

## Usage Instructions

This minimalist software does not provide any integrated tips or documentation, you should refer to this section if you need help.

### Get started

- Download the map editor.
- Unzip it.
- Add at least one tileset in the tileset/ directory.
- Edit the "editor.txt" file next to the map editor and change some settings to fit your need.
- Run the map editor.
- Create a map.
- Export your map.
- Your exported map should now appear in the map/ directory.

### Shortcuts

- Draw: d
- Erase: e
- Fill: f
- Tile picker: alt
- Move:
	- arrow
	- space (keep pressed until done) + mouse left
- Zoom: scroll

---

## Input/Output Format

A 2d map is encoded as a 2d array of numbers. Each number matches a tileset tile.

tileset\_to\_number\_img

txt\_img
json\_img
lua\_img

## Importing a Map to Your Project

### With Lua (5.1)

If your using the lua programming language you can use this piece of code(TODO link) to parse it (lua 5.1 is used for the project, it may not work with other version).

### Without Lua

Find a parser corresponding to the file format you want your map to be into, or create one (you can use this code(TODO link) as an example)

---

## Project Status
The project is currently almost finished, however feel free to open an issue if you encounter one. No features will be added.

## Why this project ?
TODO