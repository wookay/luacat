-- test_hangul.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'Hangul'


function test_string_to_uchars()
  local str = "a가b나"
  assert_equal(8, #str)
  local uchars = string_to_uchars(str)
  assert_equal(4, #uchars)
  assert_equal({"a", "가", "b", "나"}, uchars)
  assert_equal("a가b나", uchars_to_string(uchars))
end

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

function test_group_by_chosung()
  local words = {'감자','마늘','고구마'}
  local group = group_by_chosung(words)
  assert_equal(
    { ['ㄱ'] = { '감자', '고구마'}, ['ㅁ'] = { '마늘' }},
    group)
end

function test_hangul_search()
  local words = {'감자','마늘','고구마'}
  assert_equal({'감자', '고구마'}, hangul_search(words, 'ㄱ'))
  assert_equal({'감자'}, hangul_search(words, '가'))
  assert_equal({'감자'}, hangul_search(words, '감'))
  assert_equal({'감자'}, hangul_search(words, '감ㅈ'))
  assert_equal({'고구마'}, hangul_search(words, '구'))
end

if is_main() then 
  UnitTest.run()
end
