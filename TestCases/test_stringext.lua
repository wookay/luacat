-- test_stringext.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'StringExt'
require 'Logger'

function test_string_multiline()
  local str = [[
a
b
]]
  assert_equal("a\nb\n", str)
end

function test_string()

  assert_equal("b", _("abcde").slice(2,2))

  assert_equal("b", String.slice("abcde", 2,2))
  assert_equal("bc", String.slice("abcde", 2,3))
  assert_equal("bcde", String.slice("abcde", 2,-1))

  assert_equal("abc", String.strip("\n abc"))
  assert_equal("abc", _("\n abc").strip())

  local str = "  a b c  "
  assert_equal("a b c", String.strip(str))
  assert_equal("a b c  ", String.lstrip(str))
  assert_equal("  a b c", String.rstrip(str))

  assert_equal({"a", "b", "c"}, String.split("a b c", SPACE))
  assert_equal({"a", "b", "c"}, _("a b c").split(SPACE))

  assert_equal(3, String.length("abc"))
  assert_equal("cba", String.reverse("abc"))
  assert_equal("ABC", String.upcase("abc"))
  assert_equal("abc", String.downcase("ABC"))

  assert_equal("", String.capitalize(""))
  assert_equal("A", String.capitalize("a"))
  assert_equal("Abc", String.capitalize("abc"))

  assert_equal("abc def", SWF("abc %s", "def"))
  assert_equal("0xff", SWF("0x%x", 255))

  assert_true(String.start_with("hello", "he"))
  assert_false(String.start_with("hello", "lo"))
  assert_true(String.end_with("", ""))
  assert_false(String.end_with("", "a"))
  assert_true(String.end_with("hello", ""))
  assert_true(String.end_with("hello", "lo"))
  assert_false(String.end_with("hello", "he"))
  assert_true(String.include("hello", "lo"))
  assert_false(String.include("hello", "loo"))

  assert_equal({"a","b","c"}, _w("a b c"))
  assert_equal("abcd", string.gsub("abcff","ff","d"))

  assert_true(String.is_empty(""))
  assert_false(String.is_empty(" "))
  assert_not_empty(" ")
  assert_not_empty("\n")
  assert_empty("")

  assert_equal(2, String.count("hello", "l"))
  assert_equal(1, String.count("hello", "ll"))
  assert_equal(0, String.count("hello", "lll"))

  assert_false(_("").is_nil())
  assert_true(_("").is_not_nil())
  assert_one_of(_("").methods(), 'split')

  assert_equal("apple", String.gsub("abc", "bc", "pple"))

  local str = 'a'
  assert_equal("ab", String.concat(str, 'b'))
  assert_equal("a", str) -- immutable
  assert_equal("aaaaa", _('a') * 5)
  assert_equal("ababab", _('ab') * 3)
end

function test_to_s()
  assert_equal("nil", to_s(nil))
  assert_equal("{}", to_s({}))
  assert_equal("{}", to_s({nil}))
  function multiple(...)
    return ...
  end
  assert_equal("1, 2", to_s(1, 2))
  assert_equal("1, 2", to_s(multiple(1,2)))
end


if is_main() then 
  UnitTest.run()
end
