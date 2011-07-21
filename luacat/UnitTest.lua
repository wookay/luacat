-- UnitTest.lua
--                           wookay.noh at gmail.com 

local inspect = require 'inspect'
require 'StringExt'
require 'TableExt'
require 'Exception'
require 'Logger'

local currentTest = nil
UnitTest = { dot_if_passed = false, tests = {}, passed = 0, failed = 0, setupAt = nil }

local function _extract_filename_line_from_debug_traceback(traceback)
  return string.lstrip(string.split(table.join(
             table.slice(string.split(traceback, LF), 4,-2), ""), ': ')[1])
end

local function _assert_equal(expected, got, expected_one, got_one)
  if expected == got then
    UnitTest.passed = UnitTest.passed + 1
    if nil ~= currentTest then
      UnitTest.tests[currentTest].passed = UnitTest.tests[currentTest].passed + 1
    end
    if UnitTest.dot_if_passed then
      io.write('.')
    else
      print("passed: " .. inspect(got_one))
    end
  else
    UnitTest.failed = UnitTest.failed + 1
    if nil ~= currentTest then
      UnitTest.tests[currentTest].failed = UnitTest.tests[currentTest].failed + 1
    end
    if UnitTest.dot_if_passed then
      io.write(LF)
    end
    print(string.format("Assertion failed in %s\nExpected: %s\nGot: %s",
      _extract_filename_line_from_debug_traceback(debug.traceback()),
      inspect(expected_one),
      inspect(got_one)))
  end
end

function assert_equal(expected, got)
  if "table" == type(expected) and "table" == type(got) then
    _assert_equal(inspect(expected), inspect(got), expected, got)
  else
    _assert_equal(expected, got, expected, got)
  end
end

function assert_nil(got)
  _assert_equal(nil, got, nil, got)
end

function assert_not_nil(got)
  _assert_equal(true, nil ~= got, "not nil", got)
end

function assert_not_empty(got)
  if "table" == type(got) then
    _assert_equal(false, table.is_empty(got), "not empty", got)
  elseif "string" == type(got) then
    _assert_equal(false, string.is_empty(got), "not empty", got)
  else
    error(SWF("assert_not_empty but %s", to_s(got)))
  end
end

function assert_one_of(expected, got)
  _assert_equal(true, table.include(expected, got), "one of", got)
end

function assert_true(got)
  _assert_equal(true, got, true, got)
end

function assert_false(got)
  _assert_equal(false, got, false, got)
end

function assert_raise(exception, fun)
  try(fun,
  function(e) _assert_equal(true, string.include(e, exception), exception, e) end)
end

function UnitTest:setup()
  UnitTest.setupAt = os.clock()
  UnitTest.dot_if_passed = true
  print("Started")
end

function UnitTest:report()
  if table.count(UnitTest.tests) > 0 then
    print(string.format("\nFinished in %.4f seconds.", os.clock() - UnitTest.setupAt))
    print(string.format("%d tests, %d assertions, %d failures, %d errors",
      table.count(UnitTest.tests),
      UnitTest.passed,
      UnitTest.failed,
      0))
  end
end

local TEST_PREFIX = 'test_'
function UnitTest:run()
  local didSetup = false
  for key,func in pairs(getfenv()) do
    if string.start_with(key, TEST_PREFIX) then
      if not didSetup then
        didSetup = true
        UnitTest:setup()
      end
      UnitTest.tests[key] = {
        test = func,
        passed = 0,
        failed = 0,
      }
      currentTest = key
      func()
      currentTest = nil
    end
  end
  UnitTest:report()
end


function is_main()
  return arg[0] == string.sub(debug.getinfo(2,'S').source,2)
end
