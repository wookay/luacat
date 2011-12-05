-- test_moai_event.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../moacat/?.lua"
require 'moacat'

function test_moai_event()
  local layer = Sim.layer()
  layer.enableTouchEvents()

  local deck = Deck.new("./images/cathead.png")
  local prop = Prop.new(deck)
  prop.origin = {0,0}
  prop.addListener(Prop.drag_listener)
  prop.addListener(Prop.ended_listener, function(event)
     moai_info('event', event.phase, event.location)
  end)
  layer.add(prop)

  local prop = Prop.new(deck)
  prop.origin = {0,Screen.height - deck.image.height}
  prop.addListener(Prop.drag_listener)
  prop.addListener(Prop.ended_listener, function()
     moai_info('prop', prop.wrap)
  end)
  layer.add(prop)

  layer.addExitButton()
end


if is_main() then
  UnitTest.run()
end
