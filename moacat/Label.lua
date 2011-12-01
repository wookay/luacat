-- Label.lua
--                           wookay.noh at gmail.com 


require 'luacat'
require 'MoaiNode'

Label = extends(MoaiNode)

function Label.initialize(self, text)
  Label.initWithText(self, text, MOAITextBox.LEFT_JUSTIFY)
end

function Label.setText(self, text)
  self.wrap:setString(text)
  self._text = text
end

function Label.getText(self)
  return self._text
end

function Label.initWithText(self, text, aligenment)
  local font = Font.new()
  local textSize = font.wrap:getScale()
  local mtextbox = MOAITextBox.new()
  mtextbox:setString(text)
  mtextbox:setTextSize(textSize)
  mtextbox:setFont(font.wrap)
  mtextbox:setAlignment(alignment)
  mtextbox:setYFlip(true)
  self.wrap = mtextbox
  self._text = text
  self._frame = {{0,0},{0,0}}
end

function Label.setOrigin(self, origin)
  self.setFrame({origin, self._frame[2]})
end

function Label.getOrigin(self)
  return self._frame[1]
end

function Label.setSize(self, size)
  self.setFrame({self._frame[1], size})
end

function Label.getSize(self)
  return self._frame[2]
end

function Label.setFrame(self, frame)
  local origin = frame[1]
  local size = frame[2]
  local x = origin[1] - Screen.halfWidth
  local y = -origin[2] + Screen.halfHeight - size[2]
  self.wrap:setRect(x, y, x+size[1], y+size[2])
  self._frame = frame
end

function Label.getFrame(self)
  return self._frame
end
