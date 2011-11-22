-- test_moai_partition.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../moacat/?.lua"
require 'moacat'

function test_moai_partition()
  local layer = Sim.layer()


  System.exit_after_seconds(0.5)
end



if is_main() then
  UnitTest.run()
end
