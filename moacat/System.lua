-- System.lua
--                           wookay.noh at gmail.com 


require 'luacat'
require 'Screen'
require 'Debug'

System = extends(Object)

function System.openWindow()
  Debug.setLogLevelAsNone()
  Debug.showLines()
  --Debug.setHistogramEnabled()

  MOAISim.openWindow("sim", Screen.width, Screen.height)
end


function System.exit()
  if Debug.HistogramEnabled then
    MOAISim.forceGarbageCollection()
    MOAISim.reportHistogram()
  end
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
