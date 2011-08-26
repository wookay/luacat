-- test_setup_teardown.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'

local TestBox = {}

function TestBox.setup(self)
  self.base = 1
end

function TestBox.teardown(self)
  self.base = 0
end

function TestBox.test_one_time(self)
  assert_equal(2, self.base + 1)
end

function TestBox.test_two_time(self)
  assert_equal(2, self.base + 1)
end


function test_testbox()
  UnitTest.run(TestBox)
end

if is_main() then
  UnitTest.run()
end
