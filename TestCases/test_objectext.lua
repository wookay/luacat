-- test_objectext.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'ObjectExt'
require 'Logger'

function test_extends()
  local A = extends(Object)
  function A.func_a(self)
    return 'A'
  end
  assert_nil(Object.superclass)
  assert_equal(Object, A.superclass)
  local a = A.new()
  a.name = 'a name'
  assert_equal(A, a.class)
  assert_equal(A.mt, getmetatable(a))
  assert_equal('a name', a.name)
  assert_equal('A', a.func_a())
  function a.func_a(self)
    return 'a'
  end
  assert_equal(A, a.class)
  assert_equal('a', a.func_a())

  local B = extends(A)
  assert_equal(A, B.superclass)
  local b = B.new()
  assert_equal(B, b.class)
  assert_equal('A', b.func_a())
  function b.func_a(self)
    return 'b'
  end
  assert_equal('b', b.func_a())

  local C = extends(B)
  assert_equal(B, C.superclass)
  local c = C.new()
  assert_equal(C, c.class)
  assert_equal('A', c.func_a())
  function b.func_a(self)
    return 'b'
  end
  assert_equal('b', b.func_a())
end


function test_initialize()
  local A = extends(Object)
  function A.initialize(self)
    self.counter = 0
  end
  function A.plus(self)
    self.counter = self.counter + 1
  end
  local a = A.new()
  assert_equal(0, a.counter)
  a.plus()
  assert_equal(1, a.counter)
end


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
  assert_equal({"func", "func2"}, _(obj).methods())
  assert_equal(obj.func, Object.method(obj, "func"))
  assert_equal(1, Object.method(obj, "func")())
end


if is_main() then 
  UnitTest.run()
end
