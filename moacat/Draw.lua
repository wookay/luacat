-- Draw.lua
--                           wookay.noh at gmail.com 

require 'luacat'
require 'Color'
require 'Screen'
require 'ScriptDeck'

Draw = extends(Object)
Draw.penColor = Color.white

local function draw_rect(fun, layer, rect)
  local origin = rect[1]
  local size = rect[2]
  local scriptDeck = ScriptDeck.new(function()
    MOAIGfxDevice.setPenColor(unpack(Draw.penColor))
    fun(unpack(centered_rect_by_size(size)))
  end, size)
  local prop = Prop.new(scriptDeck)
  prop.origin = origin
  layer.wrap:insertProp(prop.wrap)
end


function Draw.drawRect(layer, rect)
  draw_rect(MOAIDraw.drawRect, layer, rect)
end

function Draw.fillRect(layer, rect)
  draw_rect(MOAIDraw.fillRect, layer, rect)
end

function Draw.drawCircle(layer, rect)
  draw_rect(MOAIDraw.drawCircle, layer, rect)
end

function Draw.fillCircle(layer, rect)
  draw_rect(MOAIDraw.fillCircle, layer, rect)
end

--[[
   { "drawCircle",             _drawCircle },
   { "drawEllipse",            _drawEllipse },
   { "drawLine",               _drawLine },
   { "drawPoints",             _drawPoints },
   { "drawRay",                _drawRay },
   { "drawRect",               _drawRect },
   { "fillCircle",             _fillCircle },
   { "fillEllipse",            _fillEllipse },
   { "fillFan",                _fillFan },
   { "fillRect",               _fillRect },
]]--
