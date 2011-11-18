-- Sim.lua
--                           wookay.noh at gmail.com 


package.path = package.path .. ";../luacat/?.lua"
require 'luacat'
require 'System'
require 'Layer'

Sim = extends(Object)

function Sim.layer()
  local layer = Layer.new()
  System.open(layer)
  return layer
end  
