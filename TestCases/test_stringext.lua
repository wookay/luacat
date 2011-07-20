-- test_stringext.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'StringExt'

function test_string()

  assert_equal("b", string.slice("abcde",2,2))
  assert_equal("bc", string.slice("abcde",2,3))
  assert_equal("bcde", string.slice("abcde",2,-1))

  assert_equal("abc", string.strip("\n abc"))

  local str = "  a b c  "
  assert_equal("a b c", string.strip(str))
  assert_equal("a b c  ", string.lstrip(str))
  assert_equal("  a b c", string.rstrip(str))
  assert_equal({"", "a", "b", "c", ""}, string.split(str, SPACE))

  assert_equal(3, string.length("abc"))
  assert_equal("cba", string.reverse("abc"))
  assert_equal("ABC", string.upcase("abc"))
  assert_equal("abc", string.downcase("ABC"))

  assert_equal("abc def", SWF("abc %s", "def"))

  assert_equal(true, string.hasPrefix("hello", "he"))
  assert_equal(false, string.hasPrefix("hello", "hi"))

  assert_equal(true, string.include("hello", "lo"))
  assert_equal(false, string.include("hello", "lu"))

end

function test_to_s()
  assert_equal("nil", to_s(nil))
  assert_equal("{}", to_s({}))
end


if is_main() then 
  UnitTest.run()
end
