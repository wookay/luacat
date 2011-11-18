-- test_moai_sprite.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../moacat/?.lua"
require 'moacat'

function test_moai_sprite()
  local layer = Sim.layer()

  local deck = Deck.new("./images/numbers.png", {8,8})
  local prop = Prop.new(deck)
  prop.origin = {0,0}
  layer.add(prop)

  local sprite = Sprite.new(prop, { interval = 0.1 })
  sprite.play()
  --sprite.pause()

  System.exit_after_seconds(2.5)
end


if is_main() then
  UnitTest.run()
end
