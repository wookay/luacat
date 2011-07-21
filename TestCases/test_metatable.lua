-- test_all.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'

function test_metatable()
  local dict = { a = 2 }
  assert_nil(getmetatable(dict))

  setmetatable(dict, {})

  local mt = getmetatable(dict)
  assert_equal({}, mt)
end

if is_main() then
  UnitTest.run()
end
