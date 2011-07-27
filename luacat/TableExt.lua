-- TableExt.lua
--                           wookay.noh at gmail.com 

require 'ObjectExt'


-------------------
-- Array Extensions
-------------------

function Table.join(self, sep)
  return table.concat(self, sep)
end

function Table.concat(self, other)
  local ary = self
  for k,v in pairs(other) do
    table.insert(ary, v)
  end
  return ary
end

function Table.push(self, e)
  table.insert(self, e)
  return self
end

function Table.pop(self)
  local count = #self
  if 0 == count then
    return nil
  else
    local e = self[count]
    table.remove(self, count)
    return e
  end
end

function Table.reverse(self)
  local ary = {}
  for idx = #self, 1, -1 do
    table.insert(ary, self[idx])
  end
  return ary
end

function Table.index(self, obj)
  for idx,e in ipairs(self) do
    if e == obj then
      return idx
    end
  end
  return nil
end

-- http://penlight.luaforge.net/
function Table.slice(self, first, last)
  local sz = #self
  --if not first then first=1 end
  if first < 0 then first=sz+first+1 end
  if not last then last=sz end
  if last < 0 then last=sz+1+last end
  local res={}
  for i = first, last do
    table.insert(res, self[i])
  end
  return res
end

function Table.at(self, idx)
  if idx > 0 then
    return self[idx]
  else
    return Table.slice(self, idx, idx)[1]
  end
end

function Table.map_with_index(self, fun)
  local ary = {}
  for idx,e in ipairs(self) do
    table.insert(ary, fun(e, idx))
  end 
  return ary
end

function Table.reduce(self, init, fun)
  local result = init
  for _,e in pairs(self) do
    result = fun(result, e)
  end
  return result
end

function Table.sort(self, ...)
  local ary = Table.to_a(self)
  table.sort(ary, ...)
  return ary
end

function Table.include(self, element)
  for _,e in pairs(self) do
    if e == element then
      return true
    end
  end
  return false
end



------------------------
-- Dictionary Extensions
------------------------

function Table.keys(self)
  local keys = {}
  for key, _ in pairs(self) do
    table.insert(keys, key)
  end
  return keys
end

function Table.values(self)
  local values = {}
  for _, value in pairs(self) do
    table.insert(values, value)
  end
  return values
end

function Table.merge(self, kv)
  local dict = {}
  for k,v in pairs(self) do
    dict[k] = v
  end
  for k,v in pairs(kv) do
    dict[k] = v
  end
  return dict
end

function Table.has_key(self, key)
  for k,v in pairs(self) do
    if k == key then
      return true
    end
  end
  return false
end

function Table.assoc(self, key)
  for k,v in pairs(self) do
    if k == key then
      return {k,v}
    end
  end 
  return nil
end

function Table.rassoc(self, value)
  for k,v in pairs(self) do
    print(k)
    if v == value then
      return {k,v}
    end
  end 
  return nil
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

function Table.equal(a, b)
  return inspect(a) == inspect(b)
end

function Table.each(self, fun)
  for k,e in pairs(self) do
    if "number" == type(k) then fun(e) else fun({k,e}) end
  end
end

function Table.each_with_index(self, fun)
  local idx = 1
  for k,e in pairs(self) do
    if "number" == type(k) then fun(e,idx) else fun({k,e},idx) end
    idx = idx + 1
  end
end

function Table.map(self, fun)
  local ary = {}
  for k,e in pairs(self) do
    if "number" == type(k) then
      table.insert(ary, fun(e))
    else
      table.insert(ary, fun(k,e))
    end
  end 
  return ary
end

function Table.select(self, fun)
  local ary = {}
  for k,e in pairs(self) do
    if "number" == type(k) then
      if fun(e) then
        table.insert(ary, e)
      end
    else
      if fun(k,e) then
        table.insert(ary, {k,e})
      end
    end
  end
  return ary
end

function Table.reject(self, fun)
  local ary = {}
  for k,e in pairs(self) do
    if "number" == type(k) then
      if not fun(e) then
        table.insert(ary, e)
      end
    else
      if not fun(k,e) then
        table.insert(ary, {k,e})
      end
    end
  end
  return ary
end
