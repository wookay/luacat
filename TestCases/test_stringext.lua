-- test_stringext.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'StringExt'

function test_string()
  assert_equal("abc", string.strip("\n abc"))

  local str = "  a b c  "
  assert_equal("a b c", string.strip(str))
  assert_equal("a b c  ", string.lstrip(str))
  assert_equal("  a b c", string.rstrip(str))
  assert_equal({"", "a", "b", "c", ""}, string.split(str, SPACE))
end


if is_main() then 
  UnitTest.run()
end
