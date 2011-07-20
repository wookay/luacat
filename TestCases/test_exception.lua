-- test_exception.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'Exception'

function test_exception()

  local raised = 0
  try(function() string.format("%s", nil) end,
  function(e) raised = raised + 1 end)
  assert_equal(1, raised)

  assert_raise("bad argument #2 to 'format'",
               function() string.format("%s", nil) end)
end

if is_main() then
  UnitTest.run()
end
