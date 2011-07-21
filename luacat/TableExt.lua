-- TableExt.lua
--                           wookay.noh at gmail.com 


-------------------
-- Array Extensions
-------------------

function table.join(array, sep)
  return table.concat(array, sep)
end

function table.push(array, e)
  table.insert(array, e)
  return array
end

function table.pop(array)
  local count = #array
  if 0 == count then
    return nil
  else
    local e = array[count]
    table.remove(array, count)
    return e
  end
end

function table.reverse(array)
  local ary = {}
  for idx = #array, 1, -1 do
    table.insert(ary, array[idx])
  end
  return ary
end

function table.index(array, obj)
  for idx,e in ipairs(array) do
    if e == obj then
      return idx
    end
  end
  return nil
end

function table.at(array, idx)
  return array[idx]
end

-- http://snippets.luacode.org/snippets/Table_Slice_116
function table.slice(array, i1, i2)
  local n = #array
  -- default values for range
  i1 = i1 or 1
  i2 = i2 or n
  if i2 < 0 then
    i2 = n + i2 + 1
  elseif i2 > n then
    i2 = n
  end
  if i1 < 1 or i1 > n then
    return {}
  end
  local res = {}
  local k = 1
  for i = i1,i2 do
    res[k] = array[i]
    k = k + 1
  end
  return res
end

function table.map(array, fun)
  local ary = {}
  for _,e in pairs(array) do
    table.insert(ary, fun(e))
  end 
  return ary
end

function table.map_with_index(array, fun)
  local ary = {}
  for idx,e in ipairs(array) do
    table.insert(ary, fun(e, idx))
  end 
  return ary
end

function table.each(array, fun)
  for _,e in pairs(array) do
    fun(e)
  end
end

function table.each_with_index(array, fun)
  for idx,e in ipairs(array) do
    fun(e,idx)
  end
end

function table.select(array, fun)
  local ary = {}
  for _,e in pairs(array) do
    if fun(e) then
      table.insert(ary, e)
    end
  end
  return ary
end

function table.reject(array, fun)
  local ary = {}
  for _,e in pairs(array) do
    if not fun(e) then
      table.insert(ary, e)
    end
  end
  return ary
end

function table.reduce(array, init, fun)
  local result = init
  for _,e in pairs(array) do
    result = fun(result, e)
  end
  return result
end

local builtinsort = table.sort
function table.sort(array, ...)
  local ary = table.to_a(array)
  builtinsort(ary, ...)
  return ary
end

function table.include(array, element)
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

function table.keys(dict)
  local keys = {}
  for key, _ in pairs(dict) do
    table.insert(keys, key)
  end
  return keys
end

function table.values(dict)
  local values = {}
  for _, value in pairs(dict) do
    table.insert(values, value)
  end
  return values
end

function table.merge(dict, kv)
  local newDict = {}
  for k,v in pairs(dict) do
    newDict[k] = v
  end
  for k,v in pairs(kv) do
    newDict[k] = v
  end
  return newDict
end

function table.has_key(dict, key)
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
function table.count(t)
  return #table.keys(t)
end

function table.to_a(t)
  local ary = {}
  for k,v in pairs(t) do
    if "string" == type(k) then
      ary[#ary + 1] = {k,v}
    else
      ary[#ary + 1] = v
    end
  end
  return ary
end
