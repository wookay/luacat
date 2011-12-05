-- Layer.lua
--                           wookay.noh at gmail.com 

require 'luacat'
require 'MoaiNode'
require 'Device'
require 'Viewport'

Layer = extends(MoaiNode)

function Layer.initialize(self, viewport)
  local mlayer = MOAILayer2D.new()
  mlayer:setViewport(viewport.wrap)
  self.props = {}
  self.wrap = mlayer
end

function Layer.add(self, prop)
  table.insert(self.props, prop)
  self.wrap:insertProp(prop.wrap) 
end

function Layer.remove(self, prop)
  table.remove(self.props, prop)
  self.wrap:removeProp(prop.wrap) 
end

function Layer.getPartition(self)
  return self.wrap:getPartition()
end

function Layer.setParallax(self, parallax)
  self.wrap:setParallax(unpack(parallax))
end

function Layer.setCamera(self, transform)
  self.wrap:setCamera(transform.wrap)
end

function Layer.enableTouchEvents(self)
  Device.enableTouchEvents(self)
end

function Layer.disableTouchEvents(self)
  Device.disableTouchEvents(self)
end

function Layer.addExitButton(self)
  local button = TextButton.new("Exit", function()
    System.exit_after_seconds(0.1)
  end)
  button.frame = {{Screen.width - 110, 10}, {100,50}}
  self.add(button)
end

function Layer.coordForTopLeft(self)
  local xMin, yMin, xMax, yMax = self.wrap:getRect()
  local halfWidth = (xMax - xMin) / 2
  local halfHeight = (yMax - yMin) / 2
  return {{-halfWidth, -halfHeight}, {halfWidth, halfHeight}}
end
