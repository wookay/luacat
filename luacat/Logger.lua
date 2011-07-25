-- Logger.lua
--                           wookay.noh at gmail.com 


inspect = require 'inspect'
require 'ObjectExt'
require 'TableExt'
require 'Exception'
require 'StringExt'

local function _extract_filename_line_for_log_info(traceback)
  return _(_(_(traceback).
               split("in function 'log_info'")[2]).split(': ')[1]).lstrip()
end

local function print_line(line)
  print(string.format("%-23s %s", 
    _extract_filename_line_for_log_info(debug.traceback()), line))
end

function log_info(one, ...)
  local fun = function(x)
    if "string" == type(x) then
      return x
    else
      return inspect(x)
    end
  end
  local rest = {...}
  if 0 == #rest then
    print_line(fun(one))
  else
    try(function() print_line(string.format(one, unpack(Table.map(rest, fun)))) end,
    function(exception) print_line(exception, one, inspect(rest)) end)
  end
end
