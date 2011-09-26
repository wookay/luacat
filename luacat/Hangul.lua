-- Hangul.lua
--                           wookay.noh at gmail.com

require 'luacat'

EMPTY = ""
Hangul = {
  Chosungs = _w"ㄱ ㄲ ㄴ ㄷ ㄸ ㄹ ㅁ ㅂ ㅃ ㅅ ㅆ ㅇ ㅈ ㅉ ㅊ ㅋ ㅌ ㅍ ㅎ",
  Jungsungs = _w"ㅏ ㅐ ㅑ ㅒ ㅓ ㅔ ㅕ ㅖ ㅗ ㅘ ㅙ ㅚ ㅛ ㅜ ㅝ ㅞ ㅟ ㅠ ㅡ ㅢ ㅣ",
  Jongsungs = Table.concat({EMPTY}, _w"ㄱ ㄲ ㄳ ㄴ ㄵ ㄶ ㄷ ㄹ ㄺ ㄻ ㄼ ㄽ ㄾ ㄿ ㅀ ㅁ ㅂ ㅄ ㅅ ㅆ ㅇ ㅈ ㅊ ㅋ ㅌ ㅍ ㅎ"),
  ChosungOffset = 21 * 28,
  JungsungOffset = 28,
  Ga = 0xAC00,
  Hih = 0xD7A3,
}

function string_to_uchars(str)
  local uchars = {}
  local three = {}
  for k,v in pairs({str:byte(1, #str)}) do
    if v <= 127 then
      table.insert(uchars, string.char(v))
    else
      table.insert(three, v)
      if 3 == #three then
        table.insert(uchars, string.char(unpack(three)))
        three = {}
      end
    end
  end
  return uchars
end

function uchars_to_string(uchars)
  return Table.join(uchars, '')
end

function hangul_chosungs(str)
  local ary = {}
  for k,v in pairs(string_to_uchars(str)) do
    local t = hangul_split(v)
    table.insert(ary, t[1])
  end
  return ary
end

function group_by_chosung(words)
  local group = {}
  for k,word in pairs(words) do
    for k,v in pairs(string_to_uchars(word)) do
      local t = hangul_split(v)
      local chosung = t[1]
      if nil == group[chosung] then
        group[chosung] = {word}
      else
        table.insert(group[chosung], word)
      end
      break
    end
  end
  return group
end

function hangul_split(uchar)
  local n = string_to_utf8_char(uchar)
  if n >= Hangul.Ga and n <= Hangul.Hih then
    n = n - Hangul.Ga
    local n1 = float_to_int(n / Hangul.ChosungOffset) + 1
    n = n % Hangul.ChosungOffset
    local n2 = float_to_int(n / Hangul.JungsungOffset) + 1
    local n3 = float_to_int(n % Hangul.JungsungOffset) + 1
    return { Hangul.Chosungs[n1],
             Hangul.Jungsungs[n2],
             Hangul.Jongsungs[n3] }
  else
    return { uchar }
  end
end

function hangul_join(ary)
  local cho, jung, jong = ary[1], ary[2], ary[3]
  local uch = Hangul.Ga +
    (Table.index(Hangul.Chosungs, cho) - 1) * Hangul.ChosungOffset +
    (Table.index(Hangul.Jungsungs, jung) - 1) * Hangul.JungsungOffset +
    (Table.index(Hangul.Jongsungs, jong) - 1)
  return utf8_char_to_string(uch)
end

function hangul_string_split(str)
  local result = {}
  for k,v in pairs(string_to_uchars(str)) do
    table.insert(result, hangul_split(v))
  end 
  return result
end

local function _hangul_string_split_out(str)
  local result = {}
  for k,v in pairs(string_to_uchars(str)) do
    table.insert(result, Table.join(hangul_split(v), EMPTY))
  end 
  return Table.join(result, EMPTY)
end

function hangul_search(words, part)
  local target = _hangul_string_split_out(part)
  local result = {}
  for k,word in pairs(words) do
    local t = _hangul_string_split_out(word)
    if String.include(t, target) then
      table.insert(result, word)
    end
  end
  return result
end



-- part of http://luaparse.luaforge.net/libquery.lua.html
local function X(str) return tonumber(str, 16) end
local lastUtf8 = X"10FFFF"
local firstSurrogate = X"D800"
local lastSurrogate = X"DFFF"
local elevenBits = X"7FF"
local sixteenBits = X"FFFF"
local offset2 = X"C0" * 64 + X"80"
local offset3 = X"E0" * 4096 + X"80" * (64 + 1)
local offset4 = X"F0" * 262144 + X"80" * (4096 + 64 + 1)

function string_to_utf8_char(str)
  if str:find("^[\1-\127%z]$") then return str:byte()
    elseif str:find("^[\194-\223][\128-\191]$") then
      return str:byte(1) * 64 + str:byte(2) - offset2
    elseif str:find("^[\225-\236\238\239][\128-\191][\128-\191]$")
        or str:find("^\224[\160-\191][\128-\191]$")
        or str:find("^\237[\128-\159][\128-\191]$") then
      return str:byte(1) * 4096 + str:byte(2) * 64 + str:byte(3)
            - offset3
    elseif str:find("^\240[\144-\191][\128-\191][\128-\191]$")
        or str:find("^[\241\242\243][\128-\191][\128-\191][\128-\191]$")
        or str:find("^\244[\128-\143][\128-\191][\128-\191]$") then
      return (str:byte(1) * 262144 - offset4)
            + str:byte(2) * 4096 + str:byte(3) * 64 + str:byte(4)
  end
end
_u = string_to_utf8_char

function utf8_char_to_string(i)
  local strchar = string.char
  local mod = math.mod
  if i <= 127 then return strchar(i)
   elseif i <= elevenBits then
    return strchar(i / 64 + 192, mod(i, 64) + 128)
   elseif i <= sixteenBits then
    return strchar(i / 4096 + 224,
                   mod(i / 64, 64) + 128,
                   mod(i, 64) + 128)
   else
    return strchar(i / 262144 + 240,
                   mod(i / 4096, 64) + 128,
                   mod(i / 64, 64) + 128,
                   mod(i, 64) + 128)
  end
end
