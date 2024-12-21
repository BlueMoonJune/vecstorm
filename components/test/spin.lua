local c = {name = "spin", deps = {"transform"}}

function c:ctor(rate)
  c.rate = rate
end

function c:update(dt)
  local trans = self.entity:getComponent("transform")
  trans.rot = trans.rot + self.rate * dt
end

return component(c)
