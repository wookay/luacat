require 'luacat'

E = ""
Hangul = {
  CHOSUNG = _w"ㄱ ㄲ ㄴ ㄷ ㄸ ㄹ ㅁ ㅂ ㅃ ㅅ ㅆ ㅇ ㅈ ㅉ ㅊ ㅋ ㅌ ㅍ ㅎ",
  JUNGSUNG = _w"ㅏ ㅐ ㅑ ㅒ ㅓ ㅔ ㅕ ㅖ ㅗ ㅘ ㅙ ㅚ ㅛ ㅜ ㅝ ㅞ ㅟ ㅠ ㅡ ㅢ ㅣ",
  JONGSUNG = Table.concat({E}, _w"ㄱ ㄲ ㄳ ㄴ ㄵ ㄶ ㄷ ㄹ ㄺ ㄻ ㄼ ㄽ ㄾ ㄿ ㅀ ㅁ ㅂ ㅄ ㅅ ㅆ ㅇ ㅈ ㅊ ㅋ ㅌ ㅍ ㅎ"),
  CHOSUNG_OFFSET = 21 * 28,
  JUNGSUNG_OFFSET = 28,
}


function hangul_split(str)
  local n = utf8_to_int(str)
  --local n = bit.bit_and(c, 0xFFFF)
  if n >= 0xAC00 and n <= 0xD7A3 then -- 가 힣
    n = n - 0xAC00
    local n1 = math.floor(n / Hangul.CHOSUNG_OFFSET) + 1 -- 초성
    n = n % Hangul.CHOSUNG_OFFSET  -- '가' ~ '깋'에서의 순서
    local n2 = math.floor(n / Hangul.JUNGSUNG_OFFSET) + 1   -- 중성
    local n3 = math.floor(n % Hangul.JUNGSUNG_OFFSET) + 1   -- 종성
    return { Hangul.CHOSUNG[n1], Hangul.JUNGSUNG[n2], Hangul.JONGSUNG[n3] }
  else
    return { str }
  end
end

function hangul_join(ary)
  local cho = ary[1]
  local jung = ary[2]
  local jong = ary[3]
  local utf8 = 0xAC00 +
    (Table.index(Hangul.CHOSUNG, cho) - 1) * Hangul.CHOSUNG_OFFSET +
    (Table.index(Hangul.JUNGSUNG, jung) - 1) * Hangul.JUNGSUNG_OFFSET +
    (Table.index(Hangul.JONGSUNG, jong) - 1)
  return int_to_utf8(utf8)
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

function utf8_to_int(str)
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
_u = utf8_to_int

function int_to_utf8(i)
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
