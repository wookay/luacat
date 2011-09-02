-- CaseStatement.lua
--                           wookay.noh at gmail.com 

require 'TableExt'

function case(target, ...)
  Table.each_slice({...}, 2, function(pair)
    local when, fun = pair[1], pair[2]
    if 'function' == type(when) then
      return when()
    elseif target == when then
      return fun()
    end
  end)
end

function match_case(target, ...)
  Table.each_slice({...}, 2, function(pair)
    local when, fun = pair[1], pair[2]
    if 'function' == type(when) then
      return when()
    elseif 0 < #string.match(target, when) then
      return fun()
    end
  end)
end
