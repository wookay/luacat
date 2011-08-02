-- test_tableext.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'TableExt'
require 'Logger'

function test_nil()
  assert_equal(0, #{nil})
  assert_equal({}, {nil})
end

function test_lua_table()
  local a = {1,2,3}
  a[3] = 5
  a[10] = 5
  a['b'] = 5
  a.c = 5

  local cnt = 0
  for k,v in ipairs(a) do
    cnt = cnt + 1
  end
  assert_equal(3, cnt)

  cnt = 0
  for k,v in pairs(a) do
    cnt = cnt + 1
  end
  assert_equal(6, cnt)
end


function test_array()

  local array = {1,2,3,4,5}
  assert_equal({1}, Table.slice(array, 0, 1))
  assert_equal({1}, Table.slice(array, 1, 1))
  assert_equal({1,2}, Table.slice(array, 1, 2))
  assert_equal({2,3}, Table.slice(array, 2, 3))
  assert_equal({2,3,4}, Table.slice(array, 2, -2))
  assert_equal({2,3,4,5}, Table.slice(array, 2, -1))
  assert_equal("1 2 3 4 5", Table.join(array, " "))
  assert_equal("1, 2, 3, 4, 5", Table.join(array, ", "))
  assert_equal({5,4,3,2,1}, Table.reverse(array))
  assert_equal({1,2,3,4,5}, Table.to_a(array))

  assert_equal(nil, Table.at({5,6}, 0))
  assert_equal(5, Table.at({5,6}, 1))
  assert_equal(6, Table.at({5,6}, 2))
  assert_equal(nil, Table.at({5,6}, 3))
  assert_equal(6, Table.at({5,6}, -1))
  assert_equal(5, Table.at({5,6}, -2))
  assert_equal(nil, Table.at({5,6}, -3))

  assert_equal(1, Table.index({5,6}, 5))
  assert_equal(nil, Table.index({5,6}, 7))

  local pushed = Table.push(array, 6)
  assert_equal({1,2,3,4,5,6}, array)
  assert_equal({1,2,3,4,5,6}, pushed)

  local popped = Table.pop(array)
  assert_equal(6, popped)
  assert_equal({1,2,3,4,5}, array)

  assert_equal({}, Table.reverse({}))
  assert_equal({2,4,6}, Table.map({1,2,3}, function(x) return x*2 end))
  assert_equal({2,4,6}, Table.map_with_index({1,2,3}, function(x,idx) return x + idx end))
  assert_equal({1,2}, Table.select({1,2,3}, function(x) return x<=2 end))
  assert_equal({3}, Table.reject({1,2,3}, function(x) return x<=2 end))
  assert_equal(8, Table.reduce({1,2,3}, 2, function(result,x) return result + x end))

  local unsorted = {2, 3, 1}
  assert_equal({1,2,3}, Table.sort(unsorted))
  assert_equal({2,3,1}, unsorted)

  assert_equal({1,2,3}, Table.sort({2,3,1}, function(a,b) return a < b end))
  assert_equal({3,2,1}, Table.sort({2,3,1}, function(a,b) return a > b end))

  local result = {}
  Table.each({1,2,3}, function(x) Table.push(result, x) end)
  assert_equal({1,2,3}, result)
  result = {}
  Table.each_with_index({5,6,7}, function(x,idx) result[idx] = x end)
  assert_equal({5,6,7}, result)

  assert_true(Table.include({1,2,3}, 1))
  assert_false(Table.include({1,2,3}, 0))

  assert_not_empty({1})

  assert_equal(5, Table.count({1,2,3,3,5}))
  assert_equal(2, Table.count({1,2,3,3,5}, 3))

  assert_one_of(_({}).methods(), 'count')

  local a = {1,2}
  assert_equal({1,2,3,4}, Table.concat(a, {3,4}))
  assert_equal({1,2,3,4}, a)
end



function test_dictionary()
  assert_equal({}, {a,b,c})

  local dict = { a = 'apple', b = 'banana' }
  assert_equal({'a','b'}, Table.keys(dict))
  assert_equal({'apple','banana'}, Table.values(dict))
  assert_equal(2, Table.count(dict))
  assert_equal({{'a','apple'},{'b','banana'}}, Table.to_a(dict))

  local merged = Table.merge(dict, {c='cat'})
  assert_equal(2, Table.count(dict))
  assert_equal(3, Table.count(merged))
  assert_equal({'a','b','c'}, Table.sort(Table.keys(merged)))

  assert_true(Table.has_key({a=1}, 'a'))
  assert_false(Table.has_key({a=1}, 'b'))

  assert_true(_({a=1}).has_key('a'))

  local result = {}
  Table.each({a=1,b=2,c=3}, function(k,v) Table.push(result, {k,v}) end)
  --assert_equal({{'a',1},{'b',2},{'c',3}}, result)

  local dict = { one = "uno", two = "dos", three = "tres", zz = "dos"}
  assert_equal({'two',"dos"}, Table.assoc(dict, 'two'))
  --assert_equal({'two',"dos"}, Table.rassoc(dict, 'dos'))
end


if is_main() then 
  UnitTest.run()
end
