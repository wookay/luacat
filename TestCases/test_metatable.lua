-- test_all.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'Logger'

function test_metatable()
  local dict = { a = 2 }
  assert_nil(getmetatable(dict))

  setmetatable(dict, {})

  local mt = getmetatable(dict)
  assert_equal({}, mt)

  assert_nil(getmetatable(nil))
  assert_nil(getmetatable(1))
end

if is_main() then
  UnitTest.run()
end
