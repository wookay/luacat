-- Debug.lua
--                           wookay.noh at gmail.com 

Debug = {}

function Debug.on()
  MOAIDebugLines.setStyle(MOAIDebugLines.PARTITION_CELLS, 2, 1, 1, 1)
  MOAIDebugLines.setStyle(MOAIDebugLines.PARTITION_PADDED_CELLS, 1, 0.5, 0.5, 0.5)
  MOAIDebugLines.setStyle(MOAIDebugLines.PROP_WORLD_BOUNDS, 2, 0.75, 0.75, 0.75)
end
