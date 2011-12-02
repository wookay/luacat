-- Device.lua
--                           wookay.noh at gmail.com 

require 'luacat'
require 'MoaiNode'


-- DeviceManager
-- Device

local function new_device_event()
  return {
    lastLocation = nil,
    previousLocation = nil,
    hasPicked = false,
  }
end

local sharedDeviceManager = nil
DeviceManager = extends(Object)
function DeviceManager.initialize(self)
  self.layers = {}
end
function DeviceManager.updateLayer(self, layer)
  local found = false
  for k,l in pairs(self.layers) do
    if l.layer == layer then
      found = true
      break
    end
  end
  if found then
  else
    local mpartition = MOAIPartition.new()
    layer.wrap:setPartition(mpartition)
    table.insert(self.layers, {
      layer = layer,
      deviceEvent = new_device_event()
    })
  end
end

Device = {}
function Device.enableTouchEvents(layer)
  if nil == sharedDeviceManager then
    sharedDeviceManager = DeviceManager.new() 
  end
  sharedDeviceManager.updateLayer(layer)
  if MOAIInputMgr.device.pointer then
    MOAIInputMgr.device.pointer:setCallback(device_pointer_callback)
    MOAIInputMgr.device.mouseLeft:setCallback(device_mouseLeft_callback)
    --MOAIInputMgr.device.mouseRight:setCallback(device_mouseRight_callback)
  --MOAIInputMgr.device.mouseMiddle:setCallback(device_mouseMiddle_callback)
  else
    MOAIInputMgr.device.touch:setCallback(device_touch_callback)
  end
end

function Device.disableTouchEvents()
  if MOAIInputMgr.device.pointer then
    MOAIInputMgr.device.pointer:setCallback(function() end)
    MOAIInputMgr.device.mouseLeft:setCallback(function() end)
    --MOAIInputMgr.device.mouseRight:setCallback(nil)
    --MOAIInputMgr.device.mouseMiddle:setCallback(nil)
  else
    MOAIInputMgr.device.touch:setCallback(function() end)
  end
end

function device_touch_callback(eventType, idx, x, y, tapCount)
  for k,l in pairs(sharedDeviceManager.layers) do
    local worldX, worldY = l.layer.wrap:wndToWorld(x, y)
    local phase = nil
    if MOAITouchSensor.TOUCH_DOWN == eventType then
      phase = Phase.began
      l.deviceEvent.previousLocation = {worldX,worldY}
    elseif MOAITouchSensor.TOUCH_MOVE == eventType then
      phase = Phase.moved
    elseif MOAITouchSensor.TOUCH_UP == eventType then
      phase = Phase.ended
    elseif MOAITouchSensor.TOUCH_CANCEL == eventType then
      phase = Phase.cancelled
    end
    l.layer.doListener({
      phase = phase,
      location = {worldX,worldY},
      previousLocation = l.deviceEvent.previousLocation,
    })
    l.deviceEvent.previousLocation = {worldX,worldY}
  end
end

function device_pointer_callback(x, y)
  for k,l in pairs(sharedDeviceManager.layers) do
    l.deviceEvent.previousLocation = l.deviceEvent.lastLocation
    local worldX, worldY = l.layer.wrap:wndToWorld(x, y)
    l.deviceEvent.lastLocation = {worldX, worldY}
    if l.deviceEvent.hasPicked then
      l.layer.doListener({
        phase = Phase.moved,
        location = {worldX, worldY},
        previousLocation = l.deviceEvent.previousLocation,
      })
    end
  end
end

function device_mouseLeft_callback(isDown)
  for k,l in pairs(sharedDeviceManager.layers) do
    local phase = nil
    if isDown then
      l.deviceEvent.hasPicked = true
      phase = Phase.began
    else
      phase = Phase.ended
    end
    if l.deviceEvent.hasPicked then
      l.layer.doListener({
        phase = phase,
        location = l.deviceEvent.lastLocation,
        previousLocation = l.deviceEvent.previousLocation,
      })
      if isDown then
      else
        l.deviceEvent.hasPicked = false
      end
    end 
  end
end

function device_mouseRight_callback(isDown)
end

function device_mouseMiddle_callback(isDown)
end
