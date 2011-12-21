-- test_moai_prop_parent.lua
--                           wookay.noh at gmail.com 


package.path = package.path .. ";../moacat/?.lua"
require 'moacat'

function test_moai_prop_parent()
  local layer = Sim.layer()
  layer.enableTouchEvents()

  local catDeck = Deck.new("./images/cathead.png")
  assert_equal({128,128}, catDeck.size)
  local catProp = Prop.new(catDeck)
  catProp.origin = {0,0}

  local deck = Deck.new("./images/moai-attribution-black-256.png")
  assert_equal({256,256}, deck.size)
  local prop = Prop.new(deck)
  prop.origin = {100,256+64}
  prop.parent = catProp
  layer.add(prop)
  layer.add(catProp)

  local loc_fun = function(e)
    if Phase.ended == e.phase then
      --moai_info('Origin: ', catProp.origin, prop.origin)
      moai_info('Loc: ', catProp.location, prop.location)
    end
  end

  catProp.addListener(Prop.drag_listener, loc_fun)
  prop.addListener(Prop.drag_listener, loc_fun)

  layer.addExitButton()
end


if is_main() then
  UnitTest.run()
end
