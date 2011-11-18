-- Geometry.lua
--                           wookay.noh at gmail.com 


Location = {}
function Location.diff(a,b)
  return {a[1] - b[1], a[2] - b[2]}
end


Rect = {}
function Rect.unpack(rect)
  local origin = rect[1]
  local size = rect[2]
  return unpack({origin[1], origin[2], size[1], size[2]})
end

function centered_rect_by_size(size)
  local halfWidth = size[1]/2
  local halfHeight = size[2]/2
  return {-halfWidth, -halfHeight, halfWidth, halfHeight}
end
