-- test_obfuscation.lua
--                           

package.path = package.path .. ";../luacat/?.lua"
require 'luacat'


function code_obfuscate(code, names)
  local result = ''
  return result
end


function test_obfuscation()
  local code = [[
function function_a()
end
function function_b()
  function_a()
end
function_b()
]]
  local names = {'dqtgxwbrco', 'elbhgrkaoi'}
  local expected = [[
function dqtgxwbrco()
end
function elbhgrkaoi()
dqtgxwbrco()
end
elbhgrkaoi()
]]
  assert_equal(expected, code_obfuscate(code, names))
end


if is_main() then
  UnitTest.run()
end
