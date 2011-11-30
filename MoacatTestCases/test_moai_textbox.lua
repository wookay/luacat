-- test_moai_textbox.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../moacat/?.lua"
require 'moacat'

function test_moai_textbox()
  local layer = Sim.layer()

  local text = "hello\nworld"
  local mtextbox = MOAITextBox.new()
  mtextbox:setString(text)
  local font = Font.new()
  mtextbox:setFont(font.wrap)
  local textSize = font.wrap:getScale()
  mtextbox:setTextSize(textSize)
  mtextbox:setYFlip(true)
  mtextbox:setRect(0, 0, 100, font.wrap:getLineScale()*2)
  --log_info('getLineSize', mtextbox:getLineSize())
  --log_info('getStringBounds', mtextbox:getStringBounds(1, #text))
  layer.wrap:insertProp(mtextbox)

  System.exit_after_seconds(0.5)
end


if is_main() then
  UnitTest.run()
end
