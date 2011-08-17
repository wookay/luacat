

File = extends(Object)

File.initialize = function(self, opened_file)
  self.opened_file = opened_file
end

function File.open(name)
  local path = name
  local file = File.new(io.open(path, 'r'))
  return file
end

function File.read(self)
  return self.opened_file:read('*all')
end

function File.readlines(self)
  return String.split(self.read(), LF)
end

function File.close(self)
  io.close(self.opened_file)
end
