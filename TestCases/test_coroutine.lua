-- test_coroutine.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'Logger'

-- Coroutines in Lua.pdf
function test_coroutine_wrap()
  local co = coroutine.wrap(function(a)
         local c = coroutine.yield(a + 2)
         return c * 2 end
       )

  local b = co(20)
  assert_equal(22, b)

  local d = co(b + 1)
  assert_equal(46, d)
end

function test_preorder()

  function preorder(node)
    if node then
      preorder(node.left)
      coroutine.yield(node.key)
      preorder(node.right)
    end
  end

  function preorder_iterator(tree)
    return coroutine.wrap(
             function()
               preorder(tree)
           end)
  end

  function merge(t1, t2)
    local it1 = preorder_iterator(t1)
    local it2 = preorder_iterator(t2)
    local v1 = it1()
    local v2 = it2()
    while v1 or v2 do
      if v1 ~= nil and (v2 == nil or v1 < v2) then
        print(v1); v1 = it1()
      else
        print(v2); v2 = it2()
      end
    end
  end
end


if is_main() then
  UnitTest.run()
end
