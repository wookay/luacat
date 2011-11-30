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
  local font = Font.new()
  local textSize = font.wrap:getScale()
  local mtextbox = MOAITextBox.new()
  mtextbox:setString(text)
  mtextbox:setTextSize(textSize)
  mtextbox:setFont(font.wrap)
  mtextbox:setAlignment(MOAITextBox.CENTER_JUSTIFY)
  mtextbox:setYFlip(true)
  self.wrap = mtextbox
  self._frame = {{0,0},{0,0}}
end

function TextButton.setOrigin(self, origin)
  self.setFrame({origin, self._frame[2]})
end

function TextButton.getOrigin(self)
  return self._frame[1]
end

function TextButton.setSize(self, size)
  self.setFrame({self._frame[1], size})
end

function TextButton.getSize(self)
  return self._frame[2]
end

function TextButton.setFrame(self, frame)
  local origin = frame[1]
  local size = frame[2]
  local x = origin[1] - Screen.halfWidth
  local y = -origin[2] + Screen.halfHeight - size[2]
  self.wrap:setRect(x, y, x+size[1], y+size[2])
  self._frame = frame
end

function TextButton.getFrame(self)
  return self._frame
end
