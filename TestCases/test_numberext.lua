-- test_numberext.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'NumberExt'
require 'Logger'

function test_number()
  assert_equal(1, string_to_int("1"))
  assert_equal(3.14, string_to_float("3.14"))
  assert_true(3.141592653589 < PI)
  
  local random = get_random(2)
  assert_true(0 <= random)
end



if is_main() then 
  UnitTest.run()
end
