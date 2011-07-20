-- Logger.lua
--                           wookay.noh at gmail.com 


inspect = require 'inspect'
require 'TableExt'
require 'Exception'

function log_info(one, ...)
  local rest = {...}
  if 0 == #rest then
    print(inspect(one))
  else
    try(function() print(string.format(one, unpack(table.map(rest, function(x) return inspect(x) end)))) end,
    function(exception) print(exception, one, inspect(rest)) end)
  end
end
