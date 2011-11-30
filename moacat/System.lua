-- System.lua
--                           wookay.noh at gmail.com 


require 'luacat'
require 'Screen'
require 'Debug'

System = extends(Object)

function System.open(layer)
  Debug.setLogLevelAsNone()
  Debug.showLines()

  MOAISim.openWindow("sim", Screen.width, Screen.height)
  MOAISim.pushRenderPass(layer.wrap)
end

function System.exit()
  print('exit')
  os.exit()
end

function System.exit_after_seconds(delay)
  local timer = MOAITimer.new()
  timer:setSpan(delay)
  timer:setListener(MOAITimer.EVENT_TIMER_LOOP,
    function()
      timer:stop()
      timer = nil
      System.exit()
    end
  )
  timer:start()
end

function is_main()
  return nil == IsMain
end 
