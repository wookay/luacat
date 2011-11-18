-- test_moai_draw.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../moacat/?.lua"
require 'moacat'

function test_moai_draw()
  local layer = Sim.layer()
  Draw.penColor = Color.green
  Draw.fillRect(layer, {{0,0},{100,50}})

  System.exit_after_seconds(0.1)
end



if is_main() then
  UnitTest.run()
end
