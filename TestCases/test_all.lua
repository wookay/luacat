-- test_all.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'test_stringext'
require 'test_tableext'
require 'test_numberext'
require 'test_objectext'
require 'test_metatable'
require 'test_exception'


if is_main() then
  UnitTest.run()
end
