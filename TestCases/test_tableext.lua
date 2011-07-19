-- test_tableext.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'TableExt'

function test_table()
  local array = {1,2,3,4,5}
  assert_equal({1,2,3,4,5}, table.slice(array, 1, -1))
  assert_equal({2,3,4}, table.slice(array, 2, -2))
  assert_equal("1 2 3 4 5", table.join(array, " "))

  local dict = { a = 'apple', b = 'banana' }
  assert_equal({'a','b'}, table.keys(dict))
  assert_equal({'apple','banana'}, table.values(dict))
end


if is_main() then 
  UnitTest.run()
end
