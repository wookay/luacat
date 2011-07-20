-- test_logger.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'Logger'
require 'StringExt'

log_info( nil )
log_info( 123 )
log_info( "a" )
log_info( {1, 2, 3} )
log_info( {a = 1, b = 2} )
log_info( "test 1 : %d", 1 )
log_info( "test nil : %s", to_s(nil) )
log_info( "test {1} : %s", {1} )
log_info( "test {a=1} {b=1} : %s %s", {a=1}, {b=1})
log_info( {a=1, b=2, c=3, d=4, e=5, f=6, g=7, h=8, i=9, j=10, k=11} )


--[[

nil
123
"a"
{1, 2, 3}
{a = 1, b = 2}
test 1 : 1
test nil : "nil"
test {1} : {1}
test {a=1} {b=1} : {a = 1} {b = 1}
{ a = 1, 
  b = 2, 
  c = 3, 
  d = 4, 
  e = 5, 
  f = 6, 
  g = 7, 
  h = 8, 
  i = 9, 
  j = 10, 
  k = 11 }

--]]
