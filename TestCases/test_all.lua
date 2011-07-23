-- test_all.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'test_stringext'
require 'test_tableext'
require 'test_numberext'
require 'test_objectext'
require 'test_dateext'
require 'test_exception'
require 'test_metatable'
require 'test_unittest'
require 'test_luacat'


if is_main() then
  UnitTest.run()
end
