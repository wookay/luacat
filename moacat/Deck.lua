-- Deck.lua
--                           wookay.noh at gmail.com 


require 'luacat'
require 'MoaiNode'
require 'Image'
require 'Geometry'

Deck = extends(MoaiNode)

function Deck.initialize(self, path, deckSize)
  local deckSize = deckSize or {1,1}
  local image = Image.new(path)
  local size = {image.width/deckSize[1], image.height/deckSize[2]}
  local mdeck = MOAITileDeck2D.new() 
  mdeck:setSize(unpack(deckSize))
  mdeck:setRect(unpack(centered_rect_by_size(size)))
  mdeck:setTexture(image.wrap)
  self.deckSize = deckSize
  self.size = size
  self.image = image
  self.wrap = mdeck
end
