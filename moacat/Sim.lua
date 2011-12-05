-- Sim.lua
--                           wookay.noh at gmail.com 


require 'luacat'
require 'System'
require 'Layer'

Sim = extends(Object)

function Sim.push(layer)
  MOAISim.pushRenderPass(layer.wrap)
end

function Sim.layer()
  System.openWindow()

  local viewport = Viewport.new()
  local layer = Layer.new(viewport)
  Sim.push(layer)
  return layer
end  
