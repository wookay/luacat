-- test_moai_label.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../moacat/?.lua"
require 'moacat'

function test_moai_label()
  local layer = Sim.layer()

  local label = Label.new("hello")
  label.frame = {{0,0}, {100,50}}
  layer.add(label)

  label.text = "hello2"
  assert_equal("hello2", label.text)

  assert_equal({{0,0}, {100,50}}, label.frame)

  label.frame = {{100,10}, {100,50}}
  assert_equal({{100,10}, {100,50}}, label.frame)

  System.exit_after_seconds(0.5)
end


if is_main() then
  UnitTest.run()
end
