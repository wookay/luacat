-- NumberExt.lua
--                           wookay.noh at gmail.com 


require 'Exception'

PI = math.pi
FF = 255


function is_odd(num)
  return 1 == num % 2
end

function int_to_char(num)
  return string.char(num)
end

function char_to_int(char)
  return string.byte(char)
end

function string_to_int(str)
  return tonumber(str)
end

function string_to_float(str)
  if String.count(str, DOT) > 1 then
    return tonumber(string.match(str, "%d.%d"))
  else
    return tonumber(str)
  end
end

function float_to_int(num)
  return math.floor(num)
end

function Number.is_odd(self)
  return is_odd(self)
end

function Number.chr(self)
  return int_to_char(self)
end

function Number.times(self, fun)
  for idx=1, self do
    fun(idx)
  end
  return self
end

function Number.upto(self, to, fun)
  for idx=self, to do
    fun(idx)
  end
  return self
end

function Number.downto(self, to, fun)
  for idx=self, to, -1 do
    fun(idx)
  end
  return self
end



local _socket = nil
try(function() _socket = require 'socket' end, function() end)
if nil == socket then
  try(function()
    require 'luarocks.loader'
    _socket = require 'socket'
  end, function()
    _socket = { gettime = function() return os.time() end }
  end)
end
local _old_time_seed = nil
local _last_random = math.random(0,1000000000)
function get_random(num)
  while true do
    local new_time_seed = _socket.gettime() * 10000 + _last_random
    if _old_time_seed == new_time_seed then
    else
      _old_time_seed = new_time_seed
      math.randomseed(new_time_seed)
      _last_random = math.random(0,1000000000)
      local random = math.random(0,num)
      --print('seed: ', new_time_seed, 'random :', random)
      return random
    end
  end
  return math.random(0,num)
end
