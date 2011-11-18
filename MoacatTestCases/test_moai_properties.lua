-- test_moai_properties.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../moacat/?.lua"
require 'moacat'

function test_moai_properties()
  local viewport = MOAIViewport.new()
  -- moai_info('viewport', viewport)

  local layer = MOAILayer2D.new()
  -- moai_info('layer', layer)
  --[[
  <MOAILayer2D: 0x69e73910>
    Grid      nil
    Index     1
    Loc       0
    Partition nil
    Priority  nil
    Rot       0
    Scl       1
    WorldDir  1
    WorldLoc  0
    WorldRot  90
    WorldScl  1
]]--

  layer:setViewport(viewport)
  MOAISim.pushRenderPass(layer)

  local deck  = MOAIGfxQuad2D.new() 
  --moai_info('deck', deck)

  local prop = MOAIProp2D.new ()
  -- moai_info('prop', prop)
  --[[
  <MOAIProp2D: 0x6c8c7e90>
    Grid      nil
    Index     1
    Loc       0
    Priority  nil
    Rot       0
    Scl       1
    WorldDir  1
    WorldLoc  0
    WorldRot  90
    WorldScl  1
]]--

  prop:setDeck(deck)
  layer:insertProp(prop)
  --moai_info('prop', prop)
  --moai_info('layer', layer)
  --[[
  <MOAILayer2D: 0xa6ed40>
    Grid      nil
    Index     1
    Loc       0
    Partition 0x0xa6f46c <MOAIPartition>
    Priority  nil
    Rot       0
    Scl       1
    WorldDir  1
    WorldLoc  0
    WorldRot  90
    WorldScl  1
]]--

  assert_equal('MOAILayer2D', layer:getClassName()) 
  assert_equal(0, layer:getLoc()) 

  -- methods
  --log_info('layer', layer.__index)
  --log_info('layer', layer.__newindex)
end


if is_main() then
  UnitTest.run()
end
