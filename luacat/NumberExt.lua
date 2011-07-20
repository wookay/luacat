-- NumberExt.lua
--                           wookay.noh at gmail.com 

require 'ObjectExt'
require 'Exception'

PI = math.pi

function string_to_int(str)
  return tonumber(str)
end

function string_to_float(str)
  return tonumber(str)
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
