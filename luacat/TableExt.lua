-- TableExt.lua
--                           wookay.noh at gmail.com 

require 'ObjectExt'
require 'NumberExt'


-------------------
-- Array Extensions
-------------------

function Table.new(size, obj)
  local ary = {}
  for idx = 1, size or 0 do
    table.insert(ary, obj)
  end
  return ary
end

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

function Table.push(self, e, ...)
  table.insert(self, e)
  for _,v in pairs({...}) do
    table.insert(self, v)
  end 
  return self
end

function Table.pop(self, n)
  local count = #self
  if 0 == count then
    return nil
  else
    if nil == n then
      local e = self[count]
      table.remove(self, count)
      return e
    else
      local e = Table.slice(self, count-n+1, count)
      for idx = 1, n do
        table.remove(self, count - idx + 1)
      end
      return e
    end
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
  if 'table' == type(first) then
    last = first[2]
    first = first[1]
  end
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

function Table.shuffle(self)
  local ary = Table.to_a(self)
  try(function()
    table.sort(ary, function(a, b)
      local random = get_random(2)
      return 1 < random
    end)
  end, function(e)
  end)
  if (#self == #ary) then
    return ary
  else
    return Table.shuffle(self)
  end
end

function Table.first(self)
  return self[1]
end

function Table.last(self)
  return self[#self]
end

function Table.each_slice(self, n, fun)
  for idx=1, #self, n do
    fun(Table.slice(self, idx, idx+n-1))
  end
end

function Table.each_cons(self, n, fun)
  for idx=1, #self-n+1 do
    fun(Table.slice(self, idx, idx+n-1))
  end
end

function Table.delete_at(self, idx)
  local e = self[idx]
  table.remove(self, idx)
  return e
end

Table.mt.__mul = function(self, n)
  local ary = {}
  for idx = 1, n do
    Table.concat(ary, self.__value)
  end
  return ary
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

function Table.sorted_keys(self)
  return Table.sort(Table.keys(self))
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

function Table.update(self, kv)
  for k,v in pairs(kv) do
    self[k] = v
  end
end

function Table.append(self, k, v)
  local t = self[k]
  if nil == t then
    self[k] = { v }
  else
    table.insert(t, v)
    self[k] = t
  end
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

function Table.clear(self)
  for key, _ in pairs(self) do
    self[key] = nil
  end
  return self
end 

function Hash(array)
  local dict = {}
  for _,e in pairs(array) do
    dict[e[1]] = e[2]
  end
  return dict
end

-------------------
-- Array Comparison
-------------------
Table.mt.__lt = function(a, b)
  for idx,va in ipairs(a) do
    local vb = b[idx]
    if va == vb then
    else
      return va < vb
    end
  end
  return true
end

-----------
-- Iterator
-----------
function each(t)
  return coroutine.wrap(function()
    for k,v in pairs(t) do
      if "number" == type(k) then
        coroutine.yield(v)
      else
        coroutine.yield(k,v)
      end
    end
  end)
end

function sorted_each(t)
  return coroutine.wrap(function()
    local keys = Table.keys(t)
    table.sort(keys, function(a,b)
      if 'table' == type(a) and 'table' == type(b) then
        setmetatable(a, Table.mt)
        setmetatable(b, Table.mt)
        local result = a < b
        setmetatable(a, nil)
        setmetatable(b, nil)
        return result
      else
        return a < b
      end
    end)
    for _,k in pairs(keys) do
      local v = t[k]
      if 'number' == type(k) then
        coroutine.yield(v)
      else
        coroutine.yield(k,v)
      end
    end
  end)
end
