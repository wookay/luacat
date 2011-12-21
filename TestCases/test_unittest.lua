-- test_unittest.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'

function test_unittest()
  assert_equal( 1, 1 )
  assert_equal( {1}, {1} )

  assert_true( true )
  assert_false( false )
  assert_nil( nil )
  assert_not_nil(not nil)
  assert_true(not nil)

  assert_not_empty("a")
  assert_one_of({1,2}, 1)

  -- test fail
  -- assert_equal( 1, 2 )
  -- assert_equal( "", {2} )
end


function test_return_values()
  function twovalues()
    return 1,2
  end

  local a = twovalues()
  assert_equal(1, a)

  local a,b = twovalues()
  assert_equal(1, a)
  assert_equal(2, b)
end

if is_main() then
  UnitTest.run()
end
