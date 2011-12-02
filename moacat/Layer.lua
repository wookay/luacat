-- Layer.lua
--                           wookay.noh at gmail.com 

require 'luacat'
require 'MoaiNode'
require 'Device'

Layer = extends(MoaiNode)

local function layer_with_viewport()
  local mviewport = MOAIViewport.new()
  mviewport:setSize(Screen.width, Screen.height)
  mviewport:setScale(Screen.width, Screen.height)
  local mlayer = MOAILayer2D.new()
  mlayer:setViewport(mviewport)
  return mlayer
end

function Layer.initialize(self)
  local mlayer = layer_with_viewport()
  self.props = {}
  self.wrap = mlayer
end

function Layer.add(self, prop)
  table.insert(self.props, prop)
  self.wrap:insertProp(prop.wrap) 
end

function Layer.getPartition(self)
  return self.wrap:getPartition()
end

function Layer.enableTouchEvents(self)
  Device.enableTouchEvents(self)
end

function Layer.disableTouchEvents(self)
  Device.disableTouchEvents(self)
end

function Layer.coordForTopLeft(self)
  local xMin, yMin, xMax, yMax = self.wrap:getRect()
  local halfWidth = (xMax - xMin) / 2
  local halfHeight = (yMax - yMin) / 2
  return {{-halfWidth, -halfHeight}, {halfWidth, halfHeight}}
end
