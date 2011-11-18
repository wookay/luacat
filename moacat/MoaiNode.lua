-- MoaiNode.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../luacat/?.lua"
require 'luacat'

MoaiNode = extends(Object)

function MoaiNode.initialize(self)
  self.wrap = nil
  self.listeners = nil
end

function MoaiNode.setListener(self, listener)
  self.listeners = {listener}
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
    for k,listener in pairs(self.listeners) do
      listener(Table.merge(event, {target=self}))
    end
  end
end
