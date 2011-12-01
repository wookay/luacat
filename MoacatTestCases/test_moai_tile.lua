-- test_moai_tile.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../moacat/?.lua"
require 'moacat'

function test_moai_tile()
  local layer = Sim.layer()

  local deck = Deck.new("./images/numbers.png", {8,8})
  assert_equal({32,32}, deck.size)

  local deckIndex = 1
  local x,y = 1, 1
  function deck.addProp()
    local prop = Prop.new(deck)
    prop.deckIndex = deckIndex
    prop.origin = {x*32,y*32}
    layer.add(prop)
    deckIndex = deckIndex + 1
    x = x + 1
  end

  deck.addProp()
  deck.addProp()
  deck.addProp()
  deck.addProp()
  deck.addProp()
  x = 1
  y = 2
  deck.addProp()

  System.exit_after_seconds(0.6)
end


if is_main() then
  UnitTest.run()
end
