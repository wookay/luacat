-- Transform.lua
--                           wookay.noh at gmail.com 

require 'luacat'
require 'MoaiNode'

Transform = extends(MoaiNode)

function Transform.initialize(self)
  local mtransform = MOAITransform.new()
  self.wrap = mtransform
end

function Transform.getLocation(self)
  local x, y = self.wrap:getLoc()
  return {x,y}
end

function Transform.setLocation(self, location)
  return self.wrap:setLoc(unpack(location))
end

function Transform.seekLocation(self, location, length)
  local x = location[1]
  local y = location[2]
  return self.wrap:seekLoc(x, y, length or 1)
end
