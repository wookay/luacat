-- Logger.lua
--                           wookay.noh at gmail.com 


inspect = require 'inspect'
require 'ObjectExt'
require 'TableExt'
require 'Exception'
require 'StringExt'

if nil == Logger then
  Logger = {
    log_info = nil,
    log_write = nil,
  }
end

local function _extract_filename_line_for_log_info(n, traceback)
  return _(_(_(_(_(traceback).
           split(": in function '")).at(n)).split(': ')[1]).split(LF)[2]).lstrip()
end

local function print_line(n, line)
  print(string.format("%-23s %s", 
    _extract_filename_line_for_log_info(n, debug.traceback()), line))
end

function log_info_impl(n, one, ...)
  local fun = function(x)
    if "string" == type(x) then
      return x
    else
      return inspect(x)
    end
  end
  local rest = {...}
  if 0 == #rest then
    print_line(n, fun(one))
  else
    try(function()
      if 'string' == type(one) and String.include(one, PERCENT) then
        print_line(n, string.format(one, unpack(Table.map(rest, fun))))
      else
        format = Table.join(Table.new(1 + #rest, '%s'), SPACE)
        print_line(n, string.format(format, fun(one), unpack(Table.map(rest, fun))))
      end
    end,
    function(exception) print_line(n, exception, one, inspect(rest)) end)
  end
end

function log_write_impl(one, ...)
  io.write(one, ...)
  io.flush()
end

function log_info(one, ...)
  if nil == Logger.log_info then
    log_info_impl(-1, one, ...)
  else
    Logger.log_info(one, ...)
  end
end

function log_write(one, ...)
  if nil == Logger.log_write then
    log_write_impl(one, ...)
  else
    Logger.log_write(one, ...)
  end
end
