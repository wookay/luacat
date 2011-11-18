-- Font.lua
--                           wookay.noh at gmail.com 


package.path = package.path .. ";../luacat/?.lua"
require 'luacat'

Font = extends(MoaiNode)

function Font.initialize(self)
  local mfont = MOAIFont.new ()
  local charcodes = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-'
  mfont:loadFromTTF('./fonts/arial-rounded.TTF', charcodes, 12, 163)
  self.wrap = mfont
end
