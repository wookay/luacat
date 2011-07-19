-- UnitTest.lua
--                           wookay.noh at gmail.com 

local inspect = require 'inspect'
require 'StringExt'
require 'TableExt'

UnitTest = { passed = 0, failed = 0 }

local function extract_filename_line_from_debug_traceback(traceback)
  return string.strip(table.join(
             table.slice(string.split(traceback, LF), 3,-2), ""))
end

function assert_equal(expected, got)
  if "table" == type(expected) and "table" == type(got) then
    assert_equal(inspect(expected), inspect(got))
  else
    if expected ~= got then
      UnitTest.failed = UnitTest.failed + 1
      io.write(extract_filename_line_from_debug_traceback(debug.traceback()))
      io.write(string.format("\nAssertion failed\nExpected: %s\nGot: %s\n", inspect(expected), inspect(got)))
    else
      UnitTest.passed = UnitTest.passed + 1
      io.write('.')
    end
  end
end


function UnitTest:report()
  print(string.format("%d tests, %d assertions, %d failures, %d errors",
    0,
    UnitTest.passed,
    UnitTest.failed,
    0))
--Started
--Finished in 0.0231 seconds.
end
