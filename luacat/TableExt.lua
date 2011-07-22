-- TableExt.lua
--                           wookay.noh at gmail.com 

require 'ObjectExt'


-------------------
-- Array Extensions
-------------------

function Table.join(array, sep)
  return table.concat(array, sep)
end

function Table.push(array, e)
  table.insert(array, e)
  return array
end

function Table.pop(array)
  local count = #array
  if 0 == count then
    return nil
  else
    local e = array[count]
    table.remove(array, count)
    return e
  end
end

function Table.reverse(array)
  local ary = {}
  for idx = #array, 1, -1 do
    table.insert(ary, array[idx])
  end
  return ary
end

function Table.index(array, obj)
  for idx,e in ipairs(array) do
    if e == obj then
      return idx
    end
  end
  return nil
end

-- http://penlight.luaforge.net/
function Table.slice(array, first, last)
  local sz = #array
  --if not first then first=1 end
  if first < 0 then first=sz+first+1 end
  if not last then last=sz end
  if last < 0 then last=sz+1+last end
  local res={}
  for i = first, last do
    table.insert(res, array[i])
  end
  return res
end

function Table.at(array, idx)
  if idx > 0 then
    return array[idx]
  else
    return Table.slice(array, idx, idx)[1]
  end
end

function Table.map(array, fun)
  local ary = {}
  for _,e in pairs(array) do
    table.insert(ary, fun(e))
  end 
  return ary
end

function Table.map_with_index(array, fun)
  local ary = {}
  for idx,e in ipairs(array) do
    table.insert(ary, fun(e, idx))
  end 
  return ary
end

function Table.each(array, fun)
  for _,e in pairs(array) do
    fun(e)
  end
end

function Table.each_with_index(array, fun)
  for idx,e in ipairs(array) do
    fun(e,idx)
  end
end

function Table.select(array, fun)
  local ary = {}
  for _,e in pairs(array) do
    if fun(e) then
      table.insert(ary, e)
    end
  end
  return ary
end

function Table.reject(array, fun)
  local ary = {}
  for _,e in pairs(array) do
    if not fun(e) then
      table.insert(ary, e)
    end
  end
  return ary
end

function Table.reduce(array, init, fun)
  local result = init
  for _,e in pairs(array) do
    result = fun(result, e)
  end
  return result
end

local builtinsort = table.sort
function Table.sort(array, ...)
  local ary = Table.to_a(array)
  builtinsort(ary, ...)
  return ary
end

function Table.include(array, element)
  for _,e in pairs(array) do
    if e == element then
      return true
    end
  end
  return false
end



------------------------
-- Dictionary Extensions
------------------------

function Table.keys(dict)
  local keys = {}
  for key, _ in pairs(dict) do
    table.insert(keys, key)
  end
  return keys
end

function Table.values(dict)
  local values = {}
  for _, value in pairs(dict) do
    table.insert(values, value)
  end
  return values
end

function Table.merge(dict, kv)
  local newDict = {}
  for k,v in pairs(dict) do
    newDict[k] = v
  end
  for k,v in pairs(kv) do
    newDict[k] = v
  end
  return newDict
end

function Table.has_key(dict, key)
  for k,v in pairs(dict) do
    if k == key then
      return true
    end
  end
  return false
end



------------------------
-- Table Extensions
------------------------
function Table.is_empty(self)
  return 0 == Table.count(self)
end 

function Table.count(self, e)
  if nil == e then
    return #Table.keys(self)
  else
    local cnt = 0
    for k,v in pairs(self) do
      if v == e then
        cnt = cnt + 1
      end
    end 
    return cnt
  end
end

function Table.to_a(self)
  local ary = {}
  for k,v in pairs(self) do
    if "string" == type(k) then
      ary[#ary + 1] = {k,v}
    else
      ary[#ary + 1] = v
    end
  end
  return ary
end
