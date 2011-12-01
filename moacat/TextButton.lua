-- TextButton.lua
--                           wookay.noh at gmail.com 


require 'luacat'
require 'Button'
require 'Label'
require 'Screen'

TextButton = extends(Label)

function TextButton.initialize(self, text, callback)
  MoaiNode.addEndedListener(self, callback)
  Label.initWithText(self, text, MOAITextBox.CENTER_JUSTIFY)
end
