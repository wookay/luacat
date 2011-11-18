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
  prop.listener = Prop.drag_listener
  layer.add(prop)

 local prop = Prop.new(deck)
  prop.origin = {0,Screen.height - deck.image.height}
  prop.listener = Prop.drag_listener
  layer.add(prop)

  local button = TextButton.new("Exit", function()
    System.exit_after_seconds(0.1)
  end)
  layer.add(button)
end


if is_main() then
  UnitTest.run()
end
