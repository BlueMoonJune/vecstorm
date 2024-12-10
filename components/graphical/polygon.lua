local vec = require("lib.vec2")

local c = {name = "polygon"}

function c:ctor(type, points)
  self.type, self.points = type or "fill", points or {}
end

function c:draw()
  local points = {}
  for i, v in ipairs(self.points) do
    points[i*2-1] = v.x
    points[i*2] = v.y
  end
  love.graphics.polygon(self.type, points)
end

return component(c)
