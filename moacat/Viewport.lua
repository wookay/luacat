-- Viewport.lua
--                           wookay.noh at gmail.com 

require 'luacat'
require 'Screen'
require 'MoaiNode'

Viewport = extends(MoaiNode)

function Viewport.initialize(self)
  local mviewport = MOAIViewport.new()
  mviewport:setSize(Screen.width, Screen.height)
  mviewport:setScale(Screen.width, Screen.height)
  self.wrap = mviewport
end
