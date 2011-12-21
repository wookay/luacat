-- MoaiInfo.lua
--                           wookay.noh at gmail.com 

require 'luacat'

local IGNORE_METHODS = {
  'getClassName', 'getClass',
  'getAttrLink',              -- MOAINode
  'getFitting', 'getAttr',    -- MOAILayer2D
  'getTimesExecuted',         -- MOAIAnim
  'getValueAtTime',           -- MOAIAnimCurve
}
function moai_properties(obj)
  local mt = getmetatable(obj)
  if nil == mt then
    return {}
  end
  local t = getmetatable(mt).__index
  local getters = {}
  local max_name_length = 0
  for k,v in pairs(t) do
    if String.start_with(k, 'get') then
      if Table.include(IGNORE_METHODS, k) then
      else
        max_name_length = math.max(#k, max_name_length) - 1
        table.insert(getters, k)
      end
    end
  end
  local result = {}
  local format = "  %-" .. max_name_length .. "s %s"
  for k, getter in pairs(Table.sort(getters)) do
    local name = String.slice(getter, 4, -1)
    --log_info('name', name)
    local val = { obj[getter](obj) }
    local value = nil
    if 0 == #val then
      value = 'nil'
    elseif 1 == #val then
      value = tostring(val[1])
    else
      value = inspect(val)
    end
    table.insert(result, "  " .. SWF(format, name, value))
  end
  return result
end

function inspect_moai_object(obj)
  local s = tostring(obj)
  local a = String.split(s, ' <')
  local result = "\n  <" .. obj:getClassName() .. ": " ..
                   String.slice(a[1], 3, -1) .. ">\n" ..
                   Table.join(moai_properties(obj), LF)
  return result
end

function moai_info(...)
  local rest = {...}
  local ary = {}
  local found_moai_object = false
  for k,v in pairs(rest) do
    if nil == v.getClassName then
      table.insert(ary, v)
    else
      table.insert(ary, inspect_moai_object(v))
      found_moai_object = true
    end 
  end
  if found_moai_object then
    log_info(unpack(ary))
  else
    log_info(...)
  end
end
