local c = {name = "graphicsState"}

function c:ctor(props)
  self.props = props
end

function c:draw()
  love.graphics.push("all")
  for k, v in pairs(props) do
    love.graphics["set"..k:sub(1,1):upper()..k:sub(2,-1)](unpack(v))
  end
end

function c:postDraw()
  love.graphics.pop("all")
end

return component(c)
