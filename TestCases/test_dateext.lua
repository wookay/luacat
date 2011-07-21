-- test_dateext.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'DateExt'

function test_date()

  local date = Date.new(2010,10,1)
  assert_equal(2010, date.year)
  assert_equal(10, date.month)
  assert_equal(1, date.day)

  local today = Date.today()
  assert_true(2011 <= today.year)

end


if is_main() then 
  UnitTest.run()
end
