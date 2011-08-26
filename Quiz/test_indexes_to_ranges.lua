-- test_indexes_to_ranges.lua
--                           

package.path = package.path .. ";../luacat/?.lua"
require 'luacat'


function indexes_to_ranges(indexes)
  local t = {}
  return t
end


function test_indexes_to_ranges()

  local indexes = {}
  assert_equal({}, indexes_to_ranges(indexes))

  local indexes = {5}
  assert_equal({{5,1}}, indexes_to_ranges(indexes))

  local indexes = {5,6,7}
  assert_equal({{5,3}}, indexes_to_ranges(indexes))

  local indexes = {5,6,7,10,11}
  assert_equal({{5,3},{10,2}}, indexes_to_ranges(indexes))

  local indexes = {0,1,2,3,8,9,10}
  assert_equal({{0,4},{8,3}}, indexes_to_ranges(indexes))

end


if is_main() then
  UnitTest.run()
end
