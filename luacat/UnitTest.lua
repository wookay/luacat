-- UnitTest.lua
--                           wookay.noh at gmail.com 

local inspect = require 'inspect'
require 'StringExt'
require 'TableExt'

UnitTest = { dot_if_passed = false, passed = 0, failed = 0 }

local function extract_filename_line_from_debug_traceback(traceback)
  return string.strip(table.join(
             table.slice(string.split(traceback, LF), 4,-2), ""))
end

local function _assert_equal(expected, got, expected_one, got_one)
  if expected ~= got then
    UnitTest.failed = UnitTest.failed + 1
    io.write(extract_filename_line_from_debug_traceback(debug.traceback()))
    io.write(string.format("\nAssertion failed\nExpected: %s\nGot: %s\n", inspect(expected_one), inspect(got_one)))
  else
    UnitTest.passed = UnitTest.passed + 1
    if UnitTest.dot_if_passed then
      io.write('.')
    else
      print("passed: " .. inspect(got_one))
    end
  end
end

function assert_equal(expected, got)
  if "table" == type(expected) and "table" == type(got) then
    _assert_equal(inspect(expected), inspect(got), expected, got)
  else
    _assert_equal(expected, got, expected, got)
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
