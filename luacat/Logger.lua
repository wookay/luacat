-- Logger.lua
--                           wookay.noh at gmail.com 


inspect = require 'inspect'
require 'TableExt'

function log_info(one, ...)
  local rest = {...}
  if 0 == #rest then
    print(inspect(one))
  else
    print(string.format(one, unpack(
      table.map(rest, function(x) return inspect(x) end))))
  end
end
