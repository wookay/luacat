-- test_moai_draw.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../moacat/?.lua"
require 'moacat'

function test_moai_draw()
  local layer = Sim.layer()
  Draw.penColor = Color.green

  Draw.drawRect(layer, {{5,5},{100,150}})
  Draw.fillRect(layer, {{Screen.width-105,5},{100,150}})

  System.exit_after_seconds(0.5)
end



if is_main() then
  UnitTest.run()
end
