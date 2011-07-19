-- test_unittest.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'

assert_equal( 1, 1 )
assert_equal( {1}, {1} )

assert_equal( nil, nil )
assert_equal( 1, 2 )
assert_equal( 1, {2} )
