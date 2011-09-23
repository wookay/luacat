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
require 'test_unittest'
require 'test_casestatement'
require 'test_setup_teardown'
require 'test_luacat'

require 'test_metatable'
require 'test_coroutine'

require 'test_file'
require 'test_hangul'


if is_main() then
  UnitTest.run()
end
