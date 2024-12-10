local c = {name = "spin", deps = {"transform"}}

function c:ctor(rate)
  c.rate = rate
end

function c:update(dt)
  local trans = self.entity:getComponent("transform")
  print(trans, getmetatable(trans), getmetatable(trans).__index)
  for k, v in pairs(trans) do
    print(k, v)
  end
  trans.rot = trans.rot + self.rate * dt
end

return component(c)
