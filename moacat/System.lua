-- System.lua
--                           wookay.noh at gmail.com 


package.path = package.path .. ";../luacat/?.lua"
require 'luacat'
require 'Screen'
require 'Device'

System = extends(Object)

function System.open(layer)
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
