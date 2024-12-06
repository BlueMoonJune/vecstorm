

local player = {
  x = 300,
  y = 600,
  spin = 0,
  spinv = 5
}

local projectiles = {}

function lerp(a, b, t)
  return (b-a)*t+a
end

function love.load()
  love.graphics.setLineStyle("rough")
  love.window.setMode(600, 800)
  local dw, dh = love.window.getDesktopDimensions()
  love.window.setPosition(dw/2 - 300, dh/2 - 400)
end

function linepoly(...)
  local points = {...}
  for i = 1, #points, 2 do
    local x1 = points[i]
    local y1 = points[i+1]
    local x2 = points[(i+1)%#points+1]
    local y2 = points[(i+2)%#points+1]
    love.graphics.line(x1, y1, x2, y2)
  end
end


function love.draw()
  local spin = player.spin % (2 * math.pi / 3)
  for i = 0, 1 do
    linepoly(
      player.x, player.y - 10,
      player.x - 10 * math.cos(spin - math.pi / 3), player.y + 10,
      player.x, player.y + 15,
      player.x - 10 * math.cos(spin + math.pi / 3), player.y + 10
    )
    if spin > math.pi / 3 then break end
    spin = spin + math.pi * 2 / 3
  end
end

function love.update(dt)
  player.spin = player.spin + player.spinv * dt

  local speed = 200 * dt
  if love.keyboard.isDown("w") then player.y = player.y - speed end
  if love.keyboard.isDown("a") then player.x = player.x - speed end
  if love.keyboard.isDown("s") then player.y = player.y + speed end
  if love.keyboard.isDown("d") then player.x = player.x + speed end

  local w, h = love.graphics.getDimensions()
  local t = 0.01 ^ dt

  if player.x < 50 then player.x = lerp(50, player.x, t) end
  if player.x > w - 50 then player.x = lerp(w - 50, player.x, t) end
  if player.y > h - 50 then player.y = lerp(h - 50, player.y, t) end

end
