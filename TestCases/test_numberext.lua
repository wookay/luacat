-- test_numberext.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'NumberExt'
require 'Logger'

function test_number()
  assert_equal("number", type(1))
  assert_equal("a", int_to_char(97))
  assert_equal(97, char_to_int("a"))
  assert_equal("1", to_s(1))

  assert_equal(1, string_to_int("1"))
  assert_equal(3.14, string_to_float("3.14"))
  assert_equal(1.2, string_to_float("1.2.3"))
  assert_true(3.141592653589 < PI)
  
  assert_false(_(0).is_odd())
  assert_true(_(1).is_odd())
  assert_false(is_odd(0))
  assert_true(is_odd(1))
  assert_false(is_odd(2))
  assert_true(is_odd(3))

  assert_one_of(_(1).methods(), 'is_odd')

  local random = get_random(2)
  assert_true(0 <= random)
end

function test_number_block()
  local ary = {}
  _(3).times(function(n)
    table.insert(ary, n)
  end)
  assert_equal({1,2,3}, ary)

  local ary = {}
  _(1).upto(3, function(n)
    table.insert(ary, n)
  end)
  assert_equal({1,2,3}, ary)

  local ary = {}
  _(3).downto(1, function(n)
    table.insert(ary, n)
  end)
  assert_equal({3,2,1}, ary)
end



if is_main() then 
  UnitTest.run()
end
