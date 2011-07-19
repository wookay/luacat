-- test_tableext.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'TableExt'

function test_array()
  local array = {1,2,3,4,5}
  assert_equal({1,2,3,4,5}, table.slice(array, 1, -1))
  assert_equal({2,3,4}, table.slice(array, 2, -2))
  assert_equal("1 2 3 4 5", table.join(array, " "))
  assert_equal(5, table.count(array))
  assert_equal({5,4,3,2,1}, table.reverse(array))
  assert_equal({}, table.reverse({}))
end

function test_dictionary()
  local dict = { a = 'apple', b = 'banana' }
  assert_equal({'a','b'}, table.keys(dict))
  assert_equal({'apple','banana'}, table.values(dict))
  assert_equal(2, table.count(dict))
end


if is_main() then 
  UnitTest.run()
end
