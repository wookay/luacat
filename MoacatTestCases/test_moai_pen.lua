-- test_moai_pen.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../moacat/?.lua"
require 'moacat'

function test_moai_pen()
  local layer = Sim.layer()

  local pen = Pen.new(layer)
  pen.width = 3
  pen.drawRect({{5,5},{100,150}})

  local pen = Pen.new(layer)
  pen.color = Color.green
  pen.fillRect({{Screen.width-105,5},{100,150}})

  System.exit_after_seconds(0.5)
end



if is_main() then
  UnitTest.run()
end
