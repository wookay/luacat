-- Draw.lua
--                           wookay.noh at gmail.com 

require 'luacat'
require 'Color'

Draw = extends(Object)
Draw.penColor = Color.white

function Draw.fillRect(obj, rect)
  local mscriptDeck = MOAIScriptDeck.new()
  mscriptDeck:setRect(Rect.unpack(rect))
  mscriptDeck:setDrawCallback(function()
    MOAIGfxDevice.setPenColor(unpack(Draw.penColor))
    MOAIDraw.fillRect(Rect.unpack(rect))
  end)
  local mprop = MOAIProp2D.new()
  mprop:setDeck(mscriptDeck)
  obj.wrap:insertProp(mprop)
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
