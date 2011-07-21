-- StringExt.lua
--                           wookay.noh at gmail.com 

LF = "\n"
DOT = "."
SPACE = " "

function SWF(format, ...)
  return string.format(format, ...)
end

function _w(str)
  return string.split(str, SPACE)
end

function to_s(obj)
  return inspect(obj)
end

function string.is_empty(str)
  return 0 == #str
end

function string.slice(str, from, to)
  return string.sub(str, from, to)
end

function string.split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end



local PLAIN = true
-- http://penlight.luaforge.net/
local function _find_all(s,sub,first,last)
  local i1,i2 = string.find(s,sub,first,PLAIN)
  local res = 0
  local k = 0
  while i1 do
    res = i1
    k = k + 1
    i1,i2 = string.find(s,sub,i2+1,PLAIN)
    if last and i1 > last then
      break
    end
  end
  return res,k
end
local function _strip(str, stripLeft, stripRight)
    if stripLeft then
        local i1,i2 = string.find(str, '^%s*')
        if i2 >= i1 then
            str = string.sub(str, i2+1)
        end
    end
    if stripRight then
        local i1,i2 = string.find(str, '%s*$')
        if i2 >= i1 then
            str = string.sub(str, 1, i1-1)
        end
    end
    return str
end

function string.count(str, substr)
  local _,cnt = _find_all(str, substr, 1)
  return cnt
end

function string.strip(str)
  return _strip(str, true, true)
end

function string.lstrip(str)
  return _strip(str, true, false)
end

function string.rstrip(str)
  return _strip(str, false, true)
end

function string.length(str)
  return string.len(str)
end

function string.upcase(str)
  return string.upper(str)
end

function string.downcase(str)
  return string.lower(str)
end

function string.start_with(str, prefix)
  return string.find(str, prefix, 1, PLAIN) == 1
end

function string.end_with(str, suffix)
  local idx = #str - #suffix + 1
  return string.find(str, suffix, idx, PLAIN) == idx
end

function string.include(str, substr)
  return nil ~= string.find(str, substr, 1)
end
