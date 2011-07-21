-- NumberExt.lua
--                           wookay.noh at gmail.com 

require 'ObjectExt'
require 'Exception'

PI = math.pi
FF = 255

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
  if string.count(str, DOT) > 1 then
    return tonumber(string.match(str, "%d.%d"))
  else
    return tonumber(str)
  end
end

function is_odd(num)
  return 1 == num % 2
end


local _socket = nil
try(function() _socket = require'socket' end, function(e) end)
function get_random(num)
  if is_nil(_socket) then
    math.randomseed(os.time()*10000000)
  else
    math.randomseed(_socket.gettime()*10000)
  end
  return math.random(0,num)
end
