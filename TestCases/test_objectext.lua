-- test_objectext.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'ObjectExt'

function test_object()

  assert_true(_(nil).is_nil())
  assert_false(_(nil).is_not_nil())
  assert_false(_(0).is_nil())
  assert_true(_(0).is_not_nil())

  assert_nil(nil)
  assert_not_nil(not nil)
  assert_true(is_nil(nil))
  assert_true(is_not_nil(0))

  local obj = {}
  function obj.func()
    return 1
  end
  function obj.func2()
    return 2
  end
  assert_equal({"func", "func2"}, Object.methods(obj))
  assert_equal(obj.func, Object.method(obj, "func"))
  assert_equal(1, Object.method(obj, "func")())
end


if is_main() then 
  UnitTest.run()
end
