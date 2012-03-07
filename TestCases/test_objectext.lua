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
  function c.func_a(self)
    return 'c'
  end
  assert_equal('c', c.func_a())

  function B.func_a(self)
    return 'B'
  end
  local b2 = B.new()
  assert_equal('B', b2.func_a())

  function C.func_a(self)
    return 'C'
  end
  local c2 = C.new()
  assert_equal('C', c2.func_a())
end


function test_initialize()
  local A = extends(Object)
  function A.initialize(self)
    self.counter = 0
  end
  function A.plus_one(self)
    self.counter = self.counter + 1
  end
  local a = A.new()
  assert_equal(0, a.counter)
  a.plus_one()
  assert_equal(1, a.counter)
end

function test_initialize_with_arguments()
  local A = extends(Object)
  function A.initialize(self, init)
    self.counter = init
  end
  function A.plus_one(self)
    self.counter = self.counter + 1
  end
  local a = A.new(5)
  local a2 = A.new(5)
  assert_equal(5, a.counter)
  a.plus_one()
  assert_equal(6, a.counter)
  assert_equal(5, a2.counter)
  a2.plus_one()
  assert_equal(6, a2.counter)
end

function test_subclass_initialize_with_arguments()
  local A = extends(Object)
  function A.initialize(self, init)
    self.counter = init
  end
  local B = extends(A)
  local b = B.new(5)
  assert_equal(5, b.counter)
end


function test_is_nil()
  assert_true(_(nil).is_nil())
  assert_false(_(nil).is_not_nil())
  assert_false(_(0).is_nil())
  assert_true(_(0).is_not_nil())

  assert_nil(nil)
  assert_not_nil(not nil)
  assert_true(is_nil(nil))
  assert_true(is_not_nil(0))
end

function test_methods()
  local klass = extends(Object)
  function klass.func()
    return 1
  end
  function klass.func2()
    return 2
  end
  assert_one_of(Object.methods(klass), 'func')
  assert_one_of(_(klass).methods(), 'func')
  assert_equal(klass.func, _(klass).method('func'))
  assert_equal(klass.func, Object.method(klass, 'func'))
  assert_equal(1, Object.method(klass, 'func')())
end

function test_import()
  local Color = extends(Object)
  local colorMap = {
    red = {255, 0, 0},
    green = {0, 255, 0},
    blue = {0, 0, 255},
    is_red = function(rgb)
      return Table.equal({255,0,0}, rgb)
    end
  }
  Color.import(colorMap)
  assert_equal({255,0,0}, Color.red)
  assert_equal({0,255,0}, Color.green)
  assert_equal({0,0,255}, Color.blue)
  assert_true(Color.is_red({255,0,0}))
  assert_false(Color.is_red({0,255,0}))
end

function test_getter_setter()
  local A = extends(Object)
  function A.getColor(self)
    return self._color
  end
  function A.setColor(self, color)
    self._color = Table.concat(color, {255})
  end
  local a = A.new()
  a.color = {0,0,0}
  assert_equal({0,0,0,255}, a.color)

  local B = extends(A)
  local b = B.new()
  b.color = {0,0,1}
  assert_equal({0,0,1,255}, b.color)
end

function test_getter_setter_self()
  local A = extends(Object)
  function A.three(self)
    return 3
  end
  function A.getNum(self)
    return self._num + self.three()
  end
  function A.setNum(self, n)
    self._num = n + self.three()
  end
  local a = A.new()
  a.num = 1
  assert_equal(7, a.num)
end

function test_synthesize()
  local A = extends(Object) 
  function A.initialize(self)
    self.person = { name = 'Finn', age = 15 }
  end
  A.synthesize({'name','age'}, function(self) return self.person end)
  local a = A.new()
  assert_equal('Finn', a.person.name)
  assert_equal('Finn', a.name)
  a.name = 'Jake'
  assert_equal('Jake', a.person.name)
  assert_equal('Jake', a.name)
  assert_equal(15, a.age)
end

function test_wrap_synthesize()
  local A = extends(Object)
  function A:initialize()
    self.value = 1
  end
  function A:getVal()
    return self.value
  end 
  function A:setVal(val)
    self.value = val
  end 
  local B = extends(Object) 
  function B.initialize(self)
    self.wrap = A.new()
  end
  B.wrap_synthesize({'val'})

  local b = B.new()
  assert_equal(1, b.val)
end

function test_lua_object()
  assert_equal(3, ("abc"):len())
  assert_equal(3, _("abc"):length())
  assert_equal(3, _("abc").length())

  assert_equal("ABC", ("abc"):upper())
  assert_equal("ABC", _("abc"):upcase())
  assert_equal("ABC", _("abc").upcase())
end

function test_self_call_in_initialize()
  local A = extends(Object)
  function A.initialize(self)
    self.name = self.func_a()
  end
  function A.func_a(self)
    return "A"
  end
  local a = A.new()
  assert_equal("A", a.name)
  assert_true(a.is_a(A))

  local B = extends(A)
  local b = B.new()
  assert_true(b.is_a(B))
  assert_true(b.is_a(A))
end

if is_main() then 
  UnitTest.run()
end
