-- Logger.lua
--                           wookay.noh at gmail.com 


inspect = require 'inspect'

function log_info(one, ...)
  local rest = {...}
  if 0 == #rest then
    print(inspect(one))
  else
    print(string.format(one, inspect(unpack(rest))))
  end
end
