-- Logger.lua
--                           wookay.noh at gmail.com 


inspect = require 'inspect'
require 'TableExt'
require 'Exception'

function log_info(one, ...)
  local fun = function(x)
    if "string" == type(x) then
      return x
    else
      return inspect(x)
    end
  end
  local rest = {...}
  if 0 == #rest then
    print(fun(one))
  else
    try(function() print(string.format(one, unpack(table.map(rest, fun)))) end,
    function(exception) print(exception, one, inspect(rest)) end)
  end
end
