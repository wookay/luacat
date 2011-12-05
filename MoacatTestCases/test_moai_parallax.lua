-- test_moai_parallax.lua
--                           wookay.noh at gmail.com 


package.path = package.path .. ";../moacat/?.lua"
require 'moacat'

function test_moai_parallax()
  System.openWindow()

  local viewport = Viewport.new()

  local backLayer = Layer.new(viewport)
  backLayer.parallax = {0.1, 0.1}
  Sim.push(backLayer)


  local frontLayer = Layer.new(viewport)
  frontLayer.enableTouchEvents()
  Sim.push(frontLayer)

  local deck = Deck.new("./images/moai-attribution-black-256.png")
  local prop = Prop.new(deck)
  backLayer.add(prop)

  local camera = Transform.new()
  backLayer.camera = camera
  local cameraDeck = Deck.new("./images/camera.png")
  local cameraProp = Prop.new(cameraDeck)
  cameraProp.origin = {Screen.width - 150, Screen.height - 150}
  cameraProp.addListener(function(event)
    local offset = Location.diff(event.location, event.previousLocation)
    local loc = Location.multiplyOffset(camera.location, offset, -2)
    camera.seekLocation(loc)
  end)

  local catDeck = Deck.new("./images/cathead.png")
  local catProp = Prop.new(catDeck)
  catProp.origin = {50,150}
  catProp.addListener(Prop.drag_listener)
  frontLayer.add(catProp)
  frontLayer.add(cameraProp)

  frontLayer.addExitButton()
end


if is_main() then
  UnitTest.run()
end
