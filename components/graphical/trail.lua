local vec = require("lib.vec2").new
local c = {name = "trail", deps = {"transform"}}

function c:ctor(point, length)
  self.anchor = point
  self.length = length
  self.points = {}
end

function c:draw()
  local points = {}
  for i, v in ipairs(self.points) do
    if i == #self.points then
      break
    end
    local v2 = self.points[i+1]
    local x1, y1 = love.graphics.inverseTransformPoint(v:unpack())
    local x2, y2 = love.graphics.inverseTransformPoint(v2:unpack())
    love.graphics.line(
      x1, y1, x2, y2
    )
  end
end

function c:update(dt)
  table.insert(self.points, 0, vec(
    love.graphics.transformPoint(
      self.anchor.x, self.anchor.y
    )
  ))

  if #self.points > self.length then
    table.remove(self.points)
  end
end

return component(c)
