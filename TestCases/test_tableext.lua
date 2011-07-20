-- test_tableext.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'TableExt'

function test_nil()
  assert_equal(0, #{nil})
  assert_equal({}, {nil})
end

function test_array()
  local array = {1,2,3,4,5}
  assert_equal({1,2,3,4,5}, table.slice(array, 1, -1))
  assert_equal({2,3,4}, table.slice(array, 2, -2))
  assert_equal("1 2 3 4 5", table.join(array, " "))
  assert_equal(5, table.count(array))
  assert_equal({5,4,3,2,1}, table.reverse(array))

  local pushed = table.push(array, 6)
  assert_equal({1,2,3,4,5,6}, array)
  assert_equal({1,2,3,4,5,6}, pushed)

  local popped = table.pop(array)
  assert_equal(6, popped)
  assert_equal({1,2,3,4,5}, array)

  assert_equal({}, table.reverse({}))
  assert_equal({2,4,6}, table.map({1,2,3}, function(x) return x*2 end))
  assert_equal({2,4,6}, table.map_with_index({1,2,3}, function(x,idx) return x + idx end))
  assert_equal({1,2}, table.select({1,2,3}, function(x) return x<=2 end))
  assert_equal({3}, table.reject({1,2,3}, function(x) return x<=2 end))
  assert_equal(8, table.reduce({1,2,3}, 2, function(result,x) return result + x end))
  assert_equal({1,2,3}, table.sort({2,3,1}))

  local result = {}
  table.each({1,2,3}, function(x) table.insert(result, x) end)
  assert_equal({1,2,3}, result)
  result = {}
  table.each_with_index({5,6,7}, function(x,idx) result[idx] = x end)
  assert_equal({5,6,7}, result)
end


function test_dictionary()
  local dict = { a = 'apple', b = 'banana' }
  assert_equal({'a','b'}, table.keys(dict))
  assert_equal({'apple','banana'}, table.values(dict))
  assert_equal(2, table.count(dict))

  local merged = table.merge(dict, {c='cat'})
  assert_equal(2, table.count(dict))
  assert_equal(3, table.count(merged))
  assert_equal({'a','b','c'}, table.sort(table.keys(merged)))
end


if is_main() then 
  UnitTest.run()
end
