-- test_draw_shapes.lua
--                           

package.path = package.path .. ";../luacat/?.lua"
require 'luacat'


function draw_diamond(n)
  return ""
end

function draw_pyramid(n)
  return ""
end

function draw_inverted_pyramid(n)
  return ""
end

function draw_left_aligned_triangle(n)
  return ""
end

function draw_right_aligned_triangle(n)
  return ""
end



function test_draw_diamond()
  assert_equal([[
 * 
***
 * 
]], draw_diamond(3))
end

function test_draw_pyramid()
  assert_equal([[
  *  
 *** 
*****
]], draw_pyramid(3))
end

function test_draw_inverted_pyramid()
  assert_equal([[
*****
 *** 
  *  
]], draw_inverted_pyramid(3))
end

function test_draw_left_aligned_triangle()
  assert_equal([[
*  
** 
***
]], draw_left_aligned_triangle(3))
end

function test_draw_right_aligned_triangle()
  assert_equal([[
  *
 **
***
]], draw_right_aligned_triangle(3))
end


if is_main() then
  UnitTest.run()
end
