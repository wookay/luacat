-- test_casestatement.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'CaseStatement'

function test_case()
  local sum = 0
  case('a',
    'a', function() sum = sum + 1 end,
    'b', function() sum = sum + 2 end
  )
  assert_equal(1, sum)

  local sum = 0
  case('b',
    'a', function() sum = sum + 1 end,
    'b', function() sum = sum + 2 end
  )
  assert_equal(2, sum)

  local sum = 0
  case(1,
    1, function() sum = sum + 1 end,
    2, function() sum = sum + 2 end
  )
  assert_equal(1, sum)
end

function test_case_default()
  local sum = 0
  case(100,
    1, function() sum = sum + 1 end
  )
  assert_equal(0, sum)

  local sum = 0
  case(100,
    1, function() sum = sum + 1 end,
    function() sum = sum + 5 end
  )
  assert_equal(5, sum)
end

function test_case_duplicated()
  local sum = 0
  case('a',
    'a', function() sum = sum + 1 end,
    'a', function() sum = sum + 1 end
  )
  assert_equal(1, sum)
end

function test_match_case()
  local sum = 0
  match_case('abc',
    'a*', function() sum = sum + 1 end,
    'd*', function() sum = sum + 2 end
  )
  assert_equal(1, sum)

  local sum = 0
  match_case('abc',
    'd*', function() sum = sum + 2 end,
    function() sum = sum + 5 end
  )
  assert_equal(5, sum)
end

function test_case_result()
  local result = case(1,
    1, function() return 1 end
  )
  assert_equal(1, result)

 local result = match_case('/',
    "/a+", function() return 'a' end,
    "/b+", function() return 'b' end,
    function() return 'c' end
  )
  assert_equal('c', result)

 local result = match_case(nil,
    "/a+", function() return 'a' end,
    function() return 'c' end
  )
  assert_equal('c', result)
end

if is_main() then 
  UnitTest.run()
end
