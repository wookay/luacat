-- test_file.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'File'

function test_file()

  local f = File.open('test_file.lua')
  local content = f.read()
  assert_true(332 < #content)
  f.close()

  local f = File.open('test_file.lua')
  local lines = f.readlines()
  assert_true(24 < #lines)
  f.close()

end


if is_main() then 
  UnitTest.run()
end
