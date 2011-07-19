-- TableExt.lua
--                           wookay.noh at gmail.com 


-------------------
-- Array Extensions
-------------------

function table.join(array, sep)
  return table.concat(array, sep)
end

function table.reverse(array)
  local ary = {}
  for idx = #array, 1, -1 do
    table.insert(ary, array[idx])
  end
  return ary
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


------------------------
-- Table Extensions
------------------------
function table.count(t)
  return #table.keys(t)
end
