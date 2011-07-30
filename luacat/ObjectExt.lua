-- ObjectExt.lua
--                           wookay.noh at gmail.com 


local inspect = require 'inspect'


local function _find_method_by_name(name, klass, superclass)
  local method = klass[name]
  if nil == method then
    local super = superclass
    while nil ~= super do
      for k,v in pairs(super) do
        if k == name then
          return v
        end
      end
      super = super.superclass
    end
  else
    return method
  end
  return nil
end

function extends(superclass)
  local klass = { __type = 'class' }
  klass.superclass = superclass
  klass.mt = {
    __newindex = function(self, name, ...)
      local setterName = 'set' .. String.capitalize(name)
      local setter = _find_method_by_name(setterName, klass, superclass)
      if nil == setter then
        self.__value[name] = ...
      else
        if is_base_type(self.__type) then
          setter(self.__value, ...)
        else
          setter(self, ...)
        end
      end
      return nil
    end,

    __index = function(self, name)

      if 'class' == name then
        return klass
      elseif "nil" ~= self.__type and 'table' == type(self.__value) then
        for k,v in pairs(self.__value) do
          if k == name then
            return v
          end
       end
      end
      
      local getterName = 'get' .. String.capitalize(name)
      local getter = _find_method_by_name(getterName, klass, superclass)
      if nil == getter then
        local method = _find_method_by_name(name, klass, superclass)
        if nil ~= method then
          if is_base_type(self.__type) then
            return function(...) return method(self.__value, ...) end
          else
            return function(...) return method(self, ...) end
          end
        end
      else
        if is_base_type(self.__type) then
          return getter(self.__value)
        else
          return getter(self)
        end
      end
      return nil
    end,
  }
  klass.new = function(...)
    local initialize = _find_method_by_name('initialize', klass, superclass)
    local obj = {}
    if 'function' == type(initialize) then
      initialize(obj, ...)
    end 
    return new_object(obj, klass.mt, 'object')
  end
  klass.import = function(dict, fun)
    local func = fun or function(k,v) return v end
    for k,v in pairs(dict) do
      klass[k] = func(k,v)
    end
  end
  klass.synthesize = function(list, fun)
    for _,name in pairs(list) do
      local getterName = 'get' .. String.capitalize(name)
      local setterName = 'set' .. String.capitalize(name)
      klass[getterName] = function(self)
        return fun(self)[name]
      end
      klass[setterName] = function(self, val)
        fun(self)[name] = val
      end
    end
  end
  return klass
end

function is_base_type(t)
  local baseMap = {
    boolean = true,
    number = true,
    string = true,
    table = true,
  }
  baseMap['nil'] = true
  baseMap['function'] = true
  return baseMap[t]
end


Object = { mt = {} }
Number = extends(Object)
String = extends(Object)
Table = extends(Object)
Nil = extends(Object)
Boolean = extends(Object)
Function = extends(Object)


function new_object(value, mt, objType)
  local valueTable = { __type = objType, __value = value}
  setmetatable(valueTable, mt)
  return valueTable
end

function _(obj)
  local mtMap = {
    boolean = Boolean.mt,
    number = Number.mt,
    string = String.mt,
    table = Table.mt,
  }
  mtMap['nil'] = Nil.mt
  mtMap['function'] = Function.mt
  local objType = type(obj)
  local mt = mtMap[objType]
  return new_object(obj, mt, objType)
end

function is_nil(obj)
  return nil == obj
end

function is_not_nil(obj)
  return nil ~= obj
end



function Object.is_nil(self)
  return is_nil(self)
end

function Object.is_not_nil(self)
  return is_not_nil(self)
end

function Object.methods(self)
  local ary = {}
  local klass = nil
  if 'table' == type(self) and nil ~= self.__type then
    if 'class' == self.__type then
      klass = self
    else
      klass = self.class
    end
  else
    klass = _(self).class
  end
  for k,v in pairs(klass) do
    if "function" == type(v) then
      table.insert(ary, k)
    end
  end
  return ary
end

function Object.method(self, method)
  return self[method]
end
