-- Button.lua
--                           wookay.noh at gmail.com 


require 'luacat'
require 'MoaiNode'

Button = extends(MoaiNode)

function Button.initialize(self, callback)
  MoaiNode.addEndedListener(self, callback)
end
