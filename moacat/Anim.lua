-- Anim.lua
--                           wookay.noh at gmail.com 

require 'luacat'
require 'MoaiNode'

Anim = extends(MoaiNode)

function Anim.initialize(self, prop)
  self.prop = prop
  self.wrap = MOAIAnim.new()
end

function Anim.setCurveWithLocations(self, locations, duration)
  local xCurve = MOAIAnimCurve.new()
  local yCurve = MOAIAnimCurve.new()
  local interval = 0.5
  if nil == duration then
  else
    interval = duration / #locations
  end
  xCurve:reserveKeys(#locations)
  yCurve:reserveKeys(#locations)
  local time = 0
  for idx,loc in ipairs(locations) do
    xCurve:setKey(idx, time, loc[1])
    yCurve:setKey(idx, time, loc[2])
    time = time + interval
  end
  self.wrap:reserveLinks(2)
  self.wrap:setLink(1, xCurve, self.prop.wrap, MOAIProp2D.ATTR_X_LOC)
  self.wrap:setLink(2, yCurve, self.prop.wrap, MOAIProp2D.ATTR_Y_LOC)
end

function Anim.start(self, loop)
  if loop then
    self.wrap:setMode(MOAITimer.LOOP)
  end
  self.wrap:start()
end
