-- MoaiNode.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../luacat/?.lua"
require 'luacat'

MoaiNode = extends(Object)

function MoaiNode.initialize(self)
  self.wrap = nil
  self.listeners = nil
end

function MoaiNode.addListener(self, listener, callback)
  if nil == self.listeners then
    self.listeners = {}
  end
  table.insert(self.listeners, {
    listener = listener,
    callback = callback,
  })
end

function MoaiNode.addEndedListener(self, callback)
  MoaiNode.addListener(self, function(event)
    if Phase.ended == event.phase then
      callback(event)
    end
  end)
end

function MoaiNode.doListener(self, event)
  if Layer == self.class then
    local mprop = self.partition:propForPoint(unpack(event.location))
    if mprop then
      for k,p in pairs(self.props) do
        if mprop == p.wrap then
          p.doListener(Table.merge(event, {target=p}))
          break
        end
      end
    end
  end
  if self.listeners then
    for k,l in pairs(self.listeners) do
      l.listener(Table.merge(event, {
        target = self,
        callback = l.callback
      }))
    end
  end
end
