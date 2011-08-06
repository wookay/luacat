-- test_hangul.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'Hangul'

function test_hangul_chosungs()
  assert_equal({"a", "ㄱ", "b", "ㄴ"}, hangul_chosungs("a가b나"))
  assert_equal({"ㄱ", "ㄴ", "ㄷ"}, hangul_chosungs("가나다"))
end

function test_hangul_split_join()
  assert_equal({"ㄱ", "ㅏ", EMPTY}, hangul_split("가"))
  assert_equal({"ㅎ", "ㅏ", "ㄴ"}, hangul_split("한"))
  assert_equal({"ㄱ", "ㅡ", "ㄹ"}, hangul_split("글"))
  assert_equal("가", hangul_join({"ㄱ", "ㅏ", EMPTY}))
  assert_equal("한", hangul_join({"ㅎ", "ㅏ", "ㄴ"}))
  assert_equal("글", hangul_join({"ㄱ", "ㅡ", "ㄹ"}))
end

if is_main() then 
  UnitTest.run()
end
