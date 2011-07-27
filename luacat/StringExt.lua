-- StringExt.lua
--                           wookay.noh at gmail.com 

require 'ObjectExt'
local inspect = require 'inspect'

LF = "\n"
DOT = "."
SPACE = " "


function SWF(format, ...)
  return string.format(format, ...)
end

function _w(str)
  return String.split(str, SPACE)
end

function to_s(obj)
  return inspect(obj)
end


--------------------
-- String Extensions
--------------------

function String.is_empty(self)
  return 0 == #self
end

function String.slice(self, from, to)
  return string.sub(self, from, to)
end

function String.length(self)
  return string.len(self)
end

function String.reverse(self)
  return string.reverse(self)
end

function String.upcase(self)
  return string.upper(self)
end

function String.downcase(self)
  return string.lower(self)
end

function String.capitalize(self)
  if #self > 0 then
    return string.upper(string.sub(self, 1, 1)) .. string.sub(self, 2, -1)
  else
    return ''
  end
end

local PLAIN = true
function String.start_with(self, prefix)
  return string.find(self, prefix, 1, PLAIN) == 1
end

function String.end_with(self, suffix)
  local idx = #self - #suffix + 1
  return string.find(self, suffix, idx, PLAIN) == idx
end

function String.include(self, substr)
  return nil ~= string.find(self, substr, 1)
end

function String.split(self, pat)
    local t = {}  -- NOTE: use {n = 0} in Lua-5.0
    local fpat = "(.-)" .. pat
    local last_end = 1
    local s, e, cap = string.find(self, fpat, 1)
    while s do
       if s ~= 1 or cap ~= "" then
      table.insert(t,cap)
       end
       last_end = e+1
       s, e, cap = string.find(self, fpat, last_end)
    end
    if last_end <= #self then
       cap = string.sub(self, last_end)
       table.insert(t, cap)
    end
    return t
end

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

function String.count(self, substr)
  local _,cnt = _find_all(self, substr, 1)
  return cnt
end

function String.strip(self)
  return _strip(self, true, true)
end

function String.lstrip(self)
  return _strip(self, true, false)
end

function String.rstrip(self)
  return _strip(self, false, true)
end

function String.gsub(self, from, to)
  return string.gsub(self, from, to)
end
