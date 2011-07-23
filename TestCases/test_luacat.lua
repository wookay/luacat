package.path = package.path .. ";../luacat/?.lua"
require 'luacat'

function test_luacat()
  assert_equal(0, 0)
end


if is_main() then
  UnitTest.run()
end
