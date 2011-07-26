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


if is_main() then
  UnitTest.run()
end
