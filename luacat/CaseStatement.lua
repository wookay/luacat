-- CaseStatement.lua
--                           wookay.noh at gmail.com 

require 'TableExt'

function case(target, ...)
  local rest = {...}
  local n = 2
  for idx=1, #rest, n do
    local pair = Table.slice(rest, idx, idx+n-1)
    local when, fun = pair[1], pair[2]
    if 'function' == type(when) then
      return when()
    elseif target == when then
      return fun()
    end
  end
end

function match_case(target, ...)
  local rest = {...}
  local n = 2
  for idx=1, #rest, n do
    local pair = Table.slice(rest, idx, idx+n-1)
    local when, fun = pair[1], pair[2]
    if 'function' == type(when) then
      return when()
    elseif target then
      local one, two = string.find(target, when)
      if two and two > 0 then
        return fun()
      end
    end
  end
end
