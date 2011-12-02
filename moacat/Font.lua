-- Font.lua
--                           wookay.noh at gmail.com 


require 'luacat'

Font = extends(MoaiNode)

local DEFAULT_FONT_PATH = './fonts/arial-rounded.TTF'

function Font.initialize(self)
  local mfont = MOAIFont.new ()
  local charcodes = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-'
  mfont:loadFromTTF(DEFAULT_FONT_PATH, charcodes, 12, 163)
  self.wrap = mfont
end
