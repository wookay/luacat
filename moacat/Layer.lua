-- Layer.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../luacat/?.lua"
require 'luacat'
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
