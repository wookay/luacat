-- Label.lua
--                           wookay.noh at gmail.com 


package.path = package.path .. ";../luacat/?.lua"
require 'luacat'

Label = extends(MoaiNode)

function Label.initialize(self, text)
  local mtextbox = MOAITextBox.new ()
  mtextbox:setString(text)
  local font = Font.new()
  mtextbox:setFont(font.wrap)
  local textSize = font.wrap:getScale()
  mtextbox:setTextSize(font.wrap:getScale())
  mtextbox:setYFlip(true)
  mtextbox:setRect(0, 0, textSize*#text, textSize*2)
  self.wrap = mtextbox
end
