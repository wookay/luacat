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
  assert_equal("0xff", SWF("0x%x", 255))

  assert_true(string.start_with("hello", "he"))
  assert_false(string.start_with("hello", "lo"))
  assert_true(string.end_with("", ""))
  assert_false(string.end_with("", "a"))
  assert_true(string.end_with("hello", ""))
  assert_true(string.end_with("hello", "lo"))
  assert_false(string.end_with("hello", "he"))
  assert_true(string.include("hello", "lo"))
  assert_false(string.include("hello", "loo"))

  assert_equal({"a","b","c"}, _w("a b c"))
  assert_equal("abcd", string.gsub("abcff","ff","d"))
end

function test_to_s()
  assert_equal("nil", to_s(nil))
  assert_equal("{}", to_s({}))
end


if is_main() then 
  UnitTest.run()
end
