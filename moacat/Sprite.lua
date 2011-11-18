-- Sprite.lua
--                           wookay.noh at gmail.com 

require 'luacat'
require 'MoaiNode'

Sprite = extends(MoaiNode)

function Sprite.initialize(self, prop, opt)
  local opt = opt or { interval = 0.2 }
  local mcurve = MOAIAnimCurve.new()
  local num = prop.deck.deckSize[1] * prop.deck.deckSize[2]
  mcurve:reserveKeys ( num )
  local t = 0.00
  for idx=1, num, 1 do
    mcurve:setKey ( idx, t, idx, MOAIEaseType.FLAT )
    t = t + opt.interval
  end

  local manim = MOAIAnim:new()
  manim:reserveLinks(1)
  manim:setLink(1, mcurve, prop.wrap, MOAIProp2D.ATTR_INDEX)
  manim:setMode(MOAITimer.LOOP)

  self.prop = prop
  self.manim = manim
end

function Sprite.play(self)
  self.manim:start()
end

function Sprite.pause(self)
  self.manim:stop()
end
