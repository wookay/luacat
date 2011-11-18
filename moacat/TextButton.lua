-- TextButton.lua
--                           wookay.noh at gmail.com 


package.path = package.path .. ";../luacat/?.lua"
require 'luacat'
require 'Button'

TextButton = extends(Button)

function TextButton.initialize(self, text, callback)
  MoaiNode.setListener(self, function(event)
    if Phase.ended == event.phase then
      callback()
    end
  end)
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
