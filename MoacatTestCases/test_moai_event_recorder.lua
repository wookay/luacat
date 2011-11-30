-- test_moai_event_recorder.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../moacat/?.lua"
require 'moacat'
require 'EventRecorder'

function test_moai_event_recorder()
  local layer = Sim.layer()
  layer.enableTouchEvents()

  function layer.addButton(title, fun)
    local button = TextButton.new(title, fun)
    button.origin = {25,25}
    layer.add(button)
  end

  --local recorder = EventRecorder.new()
  layer.addButton("Start", function()
  end)
  layer.addButton("Stop", function()
  end)
  layer.addButton("Replay", function()
  end)
  layer.addButton("Save", function()
  end)
  layer.addButton("Load", function()
  end)

end


if is_main() then
  UnitTest.run()
end
