-- test_logger.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'Logger'
require 'StringExt'

log_info( nil )
log_info( 123 )
log_info( "abc" )
log_info( {1, 2, 3} )
log_info( {a = 1, b = 2} )
log_info( "test %d %s", 123, "abc")
log_info( "test nil : %s", to_s(nil) )
log_info( "test {1} : %s", {1} )
log_info( "test {a=1} {b=2} : %s %s", {a=1}, {b=2})
log_info( {a=1, b=2, c=3, d=4, e=5, f=6, g=7, h=8, i=9, j=10, k=11} )


--[[

test_logger.lua:8       nil
test_logger.lua:9       123
test_logger.lua:10      abc
test_logger.lua:11      {1, 2, 3}
test_logger.lua:12      {a = 1, b = 2}
test_logger.lua:13      test 123 abc
test_logger.lua:14      test nil : nil
test_logger.lua:15      test {1} : {1}
test_logger.lua:16      test {a=1} {b=2} : {a = 1} {b = 2}
test_logger.lua:17      { a = 1, 
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
