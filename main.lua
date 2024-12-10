require "engine"
local vec = require("lib.vec2").new

local transform = require "components.general.transform"
local graphicsState = require "components.graphical.graphicsState"
local polygon = require "components.graphical.polygon"

createEntity()
  :addComponent(transform, vec(100, 100))
  :addComponent(polygon, "line", {vec(10, 0), vec(0, 10), vec(-10, 0), vec(0, -10)})
  :addComponent("components.test.spin", 1)
