-- Draw.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../luacat/?.lua"
require 'luacat'
require 'Color'
require 'Rect'

Draw = extends(Object)
Draw.penColor = Color.white

function Draw.fillRect(obj, rect)
  mscriptDeck = MOAIScriptDeck.new()
  mscriptDeck:setRect(unpack_rect(rect))
  mscriptDeck:setDrawCallback(function()
    MOAIGfxDevice.setPenColor(unpack(Draw.penColor))
    MOAIDraw.fillRect(unpack_rect(rect))
  end)
  mprop = MOAIProp2D.new()
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
