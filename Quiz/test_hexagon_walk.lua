-- test_hexagon_walk.lua
--                           

package.path = package.path .. ";../luacat/?.lua"
require 'luacat'

function hexagon_walker()
  return {
    walk = function(direction)
      return ""
    end
  }
end


function test_hexagon_walk()
  local h = hexagon_walker()

  assert_equal([[
 * *
* @ *
 * *
]], h.walk())

  assert_equal([[
 * *
* 1 *
 * @ *
  * *
]], h.walk('southeast'))

  assert_equal([[
 * *
* 1 * *
 * 2 @ *
  * * *
]], h.walk('east'))

  assert_equal([[
 * *
* 1 * * *
 * 2 3 @ *
  * * * *
]], h.walk('east'))

  assert_equal([[
 * *
* 1 * * *
 * 2 @ 4 *
  * * * *
]], h.walk('west'))

  assert_equal([[
 * * *
* 1 @ * *
 * 2 5 4 *
  * * * *
]], h.walk('northwest'))

  assert_equal([[
  * *
 * @ *
* 1 6 * *
 * 2 5 4 *
  * * * *
]], h.walk('northwest'))

end


if is_main() then
  UnitTest.run()
end
