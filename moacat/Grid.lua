-- Grid.lua
--                           wookay.noh at gmail.com 

require 'luacat'
require 'MoaiNode'

Grid = extends(MoaiNode)

function Grid.initialize(self, cellSize)
  local mgrid = MOAIGrid.new()
  self._cellSize = cellSize or {1,1}
  self.wrap = mgrid
end

function Grid.getCellSize(self)
  return self._cellSize
end

function Grid.getRows(self)
  local width, height = self.wrap:getSize()
  local rows = {}
  for yTile = 1, height do
    local row = {}
    for xTile = 1, width do
      table.insert(row, self.wrap:getTile(xTile, yTile))
    end
    table.insert(rows, row)
  end
  return rows
end

function Grid.setRows(self, rows)
  local width = 0
  local height = #rows
  if 0 < height then
    width = #rows[1]
  end
  local cellWidth = self._cellSize[1]
  local cellHeight = self._cellSize[2]
  self.wrap:setSize(width, height, cellWidth, cellHeight)
  for idx,row in ipairs(rows) do 
    local t = {idx}
    for k,v in pairs(row) do
      table.insert(t, v)
    end
    self.wrap:setRow(unpack(t))
  end
end
