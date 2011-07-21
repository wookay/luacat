-- ObjectExt.lua
--                           wookay.noh at gmail.com 

function is_nil(obj)
  return nil == obj
end

function is_not_nil(obj)
  return nil ~= obj
end

object = {}
function object.methods(obj)
  local ary = {}
  for k,v in pairs(obj) do
    if "function" == type(v) then
      table.insert(ary, k)
    end
  end
  return ary
end

function object.method(obj, method)
  return obj[method]
end
