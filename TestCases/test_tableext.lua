-- test_tableext.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'TableExt'

list = {1,2,3,4,5}

assert_equal({1,2,3,4,5}, table.slice(list, 1, -1))
assert_equal({2,3,4}, table.slice(list, 2, -2))

assert_equal("1 2 3 4 5", table.join(list, " "))
