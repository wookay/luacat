-- test_moai_sprite.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../moacat/?.lua"
require 'moacat'

function test_moai_sprite()
  local layer = Sim.layer()
  layer.enableTouchEvents()

  local deck = Deck.new("./images/numbers.png", {8,8})

  local prop = Prop.new(deck)
  prop.origin = {10,10}
  layer.add(prop)
  prop.addListener(Prop.drag_listener)
  local sprite = Sprite.new(prop, { interval = 0.1 })
  sprite.play()
  --sprite.pause()

  local prop = Prop.new(deck)
  prop.origin = {150,10}
  layer.add(prop)
  prop.addListener(Prop.drag_listener)
  local sprite = Sprite.new(prop, { interval = 0.2 })
  sprite.play()

  layer.addExitButton()
end


if is_main() then
  UnitTest.run()
end
