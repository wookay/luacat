-- Image.lua
--                           wookay.noh at gmail.com 

require 'luacat'
require 'MoaiNode'

Image = extends(MoaiNode)

function Image.initialize(self, path)
  local mimage = MOAIImage.new()
  mimage:load(path, MOAIImage.TRUECOLOR + MOAIImage.PREMULTIPLY_ALPHA)
  self.path = path
  self.width, self.height = mimage:getSize()
  self.wrap = mimage
end
