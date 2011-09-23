-- Exception.lua
--                           wookay.noh at gmail.com 


function try(fun, catchFun)
  local status, exception = pcall(fun)
  if not status and nil ~= catchFun then
    return catchFun(exception)
  end
end
