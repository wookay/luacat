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
  layer.addButton("Start", {210,125}, function()
    recorder.start()
    moai_info('start')
  end)
  layer.addButton("Stop", {210,175}, function()
    recorder.stop()
    moai_info('stop')
  end)
  layer.addButton("Replay", {210,225}, function()
    recorder.replay()
    moai_info('replay')
  end)
  layer.addButton("Save", {210,275}, function()
    recorder.save()
    moai_info('save')
  end)
  layer.addButton("Load", {210,325}, function()
    recorder.load()
    moai_info('load')
  end)

  layer.addExitButton()
end


if is_main() then
  UnitTest.run()
end
