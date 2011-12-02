-- Pen.lua
--                           wookay.noh at gmail.com 

require 'luacat'
require 'Color'
require 'Screen'
require 'ScriptDeck'

Pen = extends(Object)

function Pen.initialize(self, layer)
  self.actions = {}
  self.color = Color.white
  self.width = 1
  self.layer = layer
end

function Pen.addPoint(self, point) -- {x,y}
  local action = {
    draw = MOAIDraw.drawPoints,
    data = point,
    pen = {color = self.color, width = self.width},
  }
  table.insert(self.actions, action)
end

function Pen.addPoints(self, points) -- {{x,y},{x,y}}
  local action = {
    draw = MOAIDraw.drawPoints,
    data = Table.flatten(points),
    pen = {color = self.color, width = self.width},
  }
  table.insert(self.actions, action)
end

function Pen.addLine(self, from, to) -- {x,y}, {x,y}
  local action = {
    draw = MOAIDraw.drawLine,
    data = Table.flatten({from,to}),
    pen = {color = self.color, width = self.width},
  }
  table.insert(self.actions, action)
end

function Pen.addLines(self, lines) -- {{x,y},{x,y}}
  local action = {
    draw = MOAIDraw.drawLine,
    data = Table.flatten(lines),
    pen = {color = self.color, width = self.width},
  }
  table.insert(self.actions, action)
end

function Pen.addRect(self, rect)
  local size = rect[2]
  local action = {
    draw = MOAIDraw.drawRect,
    data = centered_rect_by_size(size),
    pen = {color = self.color, width = self.width},
  }
  table.insert(self.actions, action)
end

function Pen.addFilledRect(self, rect)
  local size = rect[2]
  local action = {
    draw = MOAIDraw.fillRect,
    data = centered_rect_by_size(size),
    pen = {color = self.color, width = self.width},
  }
  table.insert(self.actions, action)
end

function Pen.addCircle(self, rect)
  local size = rect[2]
  local action = {
    draw = MOAIDraw.drawCircle,
    data = centered_rect_by_size(size),
    pen = {color = self.color, width = self.width},
  }
  table.insert(self.actions, action)
end

function Pen.addFilledCircle(self, rect)
  local size = rect[2]
  local action = {
    draw = MOAIDraw.fillCircle,
    data = centered_rect_by_size(size),
    pen = {color = self.color, width = self.width},
  }
  table.insert(self.actions, action)
end

local function draw_pen_actions(layer, actions, rect)
  local origin = rect[1]
  local size = rect[2]
  local scriptDeck = ScriptDeck.new(function()
    for k,action in pairs(actions) do
      MOAIGfxDevice.setPenColor(unpack(action.pen.color))
      MOAIGfxDevice.setPenWidth(action.pen.width)
      action.draw(unpack(action.data))
    end
  end, size)
  local prop = Prop.new(scriptDeck)
  prop.origin = origin
  layer.wrap:insertProp(prop.wrap)
  return prop
end

function Pen.draw_pen_actions(self, rect)
  draw_pen_actions(self.layer, self.actions, rect)
end

function Pen.drawRect(self, rect)
  self.addRect(rect)
  self.draw_pen_actions(rect)    
end

function Pen.fillRect(self, rect)
  self.addFilledRect(rect)
  self.draw_pen_actions(rect)    
end
