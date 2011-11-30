-- TextButton.lua
--                           wookay.noh at gmail.com 


require 'luacat'
require 'Button'
require 'Screen'

TextButton = extends(Button)

function TextButton.initialize(self, text, callback)
  MoaiNode.addListener(self, function(event)
    if Phase.ended == event.phase then
      callback(event)
    end
  end)
  local mtextbox = MOAITextBox.new()
  mtextbox:setString(text)
  local font = Font.new()
  mtextbox:setFont(font.wrap)
  local textSize = font.wrap:getScale()
  mtextbox:setTextSize(textSize)
  mtextbox:setYFlip(true)
  self.wrap = mtextbox
end

function TextButton.setFrame(self, frame)
  local origin = frame[1]
  local size = frame[2]
  local x = origin[1] - Screen.halfWidth - size[1]
  local y = -origin[2] + Screen.halfHeight - size[2]
  self.wrap:setRect(x, y, x+size[1], y+size[2])
end
