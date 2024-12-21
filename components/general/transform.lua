local vec = require("lib.vec2")

local c = {name = "transform"}

function c:ctor(pos, rot, scale, origin, shear)
  self._pos = pos or vec.new(0, 0)
  self._rot = rot or 0
  self._scale = scale or vec.new(1, 1)
  self._origin = origin or vec.new(0, 0)
  self._shear = shear or vec.new(0, 0)
  self._matrix = love.math.newTransform(self._pos.x, self._pos.y, self._rot,
    self._scale.x, self._scale.y, self._origin.x, self._origin.y, self._shear.x, self._shear.y)
  self._rebuild = false
end

function c:__newindex(key, value)
  if rawget(self, "_"..key) then
    rawset(self, "_"..key, value)
    self._rebuild = true
    return
  end
  rawset(self, key, value)

end

function c:__index(key)
  if key:sub(1,1) == "_" then return end
  if key == "matrix" and rawget(self, "_rebuild") then
    self._matrix = love.math.newTransform(self._pos.x, self._pos.y, self._rot,
      self._scale.x, self._scale.y, self._origin.x, self._origin.y, self._shear.x, self._shear.y)
    self._rebuild = false
    return self._matrix
  end
  return rawget(self, "_"..key)
end

function c:draw()
  love.graphics.push()
  love.graphics.applyTransform(self.matrix)
end
function c:postDraw()
  love.graphics.pop()
end

function c:update()
  love.graphics.push()
  love.graphics.applyTransform(self.matrix)
end
function c:postUpdate()
  love.graphics.pop()
end


return component(c)
