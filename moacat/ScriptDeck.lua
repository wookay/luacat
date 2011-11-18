-- ScriptDeck.lua
--                           wookay.noh at gmail.com 


require 'luacat'
require 'MoaiNode'
require 'Geometry'

ScriptDeck = extends(Deck)

function ScriptDeck.initialize(self, drawCallback, size)
  local mscriptDeck = MOAIScriptDeck.new()
  mscriptDeck:setDrawCallback(drawCallback)
  mscriptDeck:setRect(unpack(centered_rect_by_size(size)))
  self.size = size
  self.wrap = mscriptDeck
end
