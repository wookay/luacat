-- test_moai_event_recorder.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../moacat/?.lua"
require 'moacat'
require 'EventRecorder'

function test_moai_event_recorder()
  local layer = Sim.layer()
  layer.enableTouchEvents()

  function layer.addButton(title, origin, fun)
    local button = TextButton.new(title, fun)
    button.frame = {origin, {100,40}}
    layer.add(button)
  end

  local recorder = EventRecorder.new()
  layer.addButton("Start", {210,25}, function()
    recorder.start()
    log_info('start')
  end)
  layer.addButton("Stop", {210,75}, function()
  end)
  layer.addButton("Replay", {210,125}, function()
  end)
  layer.addButton("Save", {210,175}, function()
  end)
  layer.addButton("Load", {210,225}, function()
  end)

end


if is_main() then
  UnitTest.run()
end
