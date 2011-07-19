-- test_logger.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'Logger'

log_info( nil )
log_info( 123 )
log_info( "a" )
log_info( {1, 2, 3} )
log_info( {a = 1, b = 2} )
