-- Deck.lua
--                           wookay.noh at gmail.com 


package.path = package.path .. ";../luacat/?.lua"
require 'luacat'
require 'MoaiNode'
require 'Image'

Deck = extends(MoaiNode)

function Deck.initialize(self, path, deckSize)
  local deckSize = deckSize or {1,1}
  local image = Image.new(path)
  local halfWidth = image.width/deckSize[1]/2
  local halfHeight = image.height/deckSize[2]/2
  local mdeck = MOAITileDeck2D.new() 
  mdeck:setSize(unpack(deckSize))
  mdeck:setRect(-halfWidth, -halfHeight, halfWidth, halfHeight)
  mdeck:setTexture(image.wrap)
  self.halfWidth = halfWidth
  self.halfHeight = halfHeight
  self.deckSize = deckSize
  self.image = image
  self.wrap = mdeck
end
