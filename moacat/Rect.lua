-- Rect.lua
--                           wookay.noh at gmail.com 

function unpack_rect(rect)
  local origin = rect[1]
  local size = rect[2]
  return unpack({origin[1], origin[2], size[1], size[2]})
end

function set_rect(obj, rect)
  local origin = rect[1]
  local size = rect[2]
  local x = -Screen.halfWidth + origin[1]
  local y = Screen.halfHeight - size[2] - origin[2]
  obj:setRect(x, y, x + size[1], y + size[2])
end
