-- Prop.lua
--                           wookay.noh at gmail.com 

require 'luacat'
require 'MoaiNode'
require 'Geometry'
require 'Anim'

Prop = extends(MoaiNode)

function Prop.initialize(self, deck)
  local mprop = MOAIProp2D.new()
  mprop:setDeck(deck.wrap)
  self.deck = deck
  self._grid = nil
  self.wrap = mprop
end

function Prop.setDeckIndex(self, deckIndex)
  self.wrap:setIndex(deckIndex)
end

function Prop.setOrigin(self, origin)
  local size = self.deck.size
  local x = origin[1] - Screen.halfWidth + size[1]/2
  local y = -origin[2] + Screen.halfHeight - size[2]/2
  self.wrap:setLoc(x, y)
end

function Prop.getOrigin(self)
  local xMin, yMin, xMax, yMax = self.wrap:getRect()
  local xLoc, yLoc = self.wrap:getLoc()
  local x = Screen.halfWidth + xLoc + xMin
  local y = Screen.halfHeight - yLoc + yMin
  return {x,y}
end

function Prop.setParent(self, prop)
  self.wrap:setParent(prop.wrap)
end

function Prop.getLocation(self)
  return {self.wrap:getLoc()}
end

function Prop.setLocation(self, location)
  self.wrap:setLoc(unpack(location))
end

function Prop.getPivot(self)
  return {self.wrap:getPiv()}
end

function Prop.setPivot(selfk, pivot)
  self.wrap:setPiv(unpack(pivot))
end

function Prop.getScale(self)
  return {self.wrap:getScl()}
end

function Prop.setScale(self, scale)
  self.wrap:setScl(unpack(scale))
end

function Prop.setGrid(self, grid)
  self._grid = grid
  self.wrap:setGrid(grid.wrap)
end

function Prop.getGrid(self)
  return self._grid
end

function Prop.setDeckRectDimension(self, dimension)
  self.deck.wrap:setRect(-dimension, dimension, dimension, -dimension)
  self.scale = {1, -1}
end

function Prop.animate(self, locations, duration)
  local anim = Anim.new(self)
  anim.setCurveWithLocations(locations, duration)
  return anim
end


-- listeners
function Prop.drag_listener(event)
  event.target.wrap:addLoc(unpack(
    Location.diff(event.location, event.previousLocation)))
  if event.callback then
    event.callback(event)
  end
end

function Prop.ended_listener(event)
  if Phase.ended == event.phase then
    event.callback(event)
  end
end
