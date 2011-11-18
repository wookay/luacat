-- Prop.lua
--                           wookay.noh at gmail.com 

require 'luacat'
require 'MoaiNode'
require 'Geometry'

Prop = extends(MoaiNode)

function Prop.initialize(self, deck)
  local mprop = MOAIProp2D.new()
  mprop:setDeck(deck.wrap)
  self.deck = deck
  self.wrap = mprop
end

function Prop.setOrigin(self, origin)
  local x = origin[1] - Screen.halfWidth + self.deck.halfWidth
  local y = -origin[2] + Screen.halfHeight - self.deck.halfHeight
  self.wrap:setLoc(x, y)
end

function Prop.drag_listener(event)
  event.target.wrap:addLoc(unpack(
    Location.diff(event.location, event.previousLocation)))
end

function Prop.ended_listener(event)
  if Phase.ended == event.phase then
    event.callback()
  end
end
