-- Exception.lua
--                           wookay.noh at gmail.com 


function try(fun, catchFun)
  local status, exception = pcall(fun)
  if not status then
    return catchFun(exception)
  end
end
