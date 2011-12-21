-- test_moai_image.lua
--                           wookay.noh at gmail.com 


package.path = package.path .. ";../moacat/?.lua"
require 'moacat'

function test_moai_image()
  local layer = Sim.layer()

  local deck = Deck.new("./images/cathead.png")

  local prop = Prop.new(deck)
  prop.origin = {0,0}
  layer.add(prop)

  local prop = Prop.new(deck)
  prop.origin = {Screen.width - deck.image.width,0}
  layer.add(prop)

  assert_equal({Screen.width - deck.image.width,0}, prop.origin)

  local prop = Prop.new(deck)
  prop.origin = {0,Screen.height - deck.image.height}
  layer.add(prop)

  local prop = Prop.new(deck)
  prop.origin = {Screen.width - deck.image.width,
                 Screen.height - deck.image.height}
  layer.add(prop)

  local prop = Prop.new(deck)
  prop.origin = {Screen.halfWidth - deck.image.width/2,
                 Screen.halfHeight - deck.image.height/2}
  layer.add(prop)

  assert_equal('MOAILayer2D', layer.wrap:getClassName()) 
  assert_equal(0, layer.wrap:getLoc()) 

  System.exit_after_seconds(0.5)
end


if is_main() then
  UnitTest.run()
end
