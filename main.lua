require "engine"
local vec = require("lib.vec2").new

local transform = require "components.general.transform"
local graphicsState = require "components.graphical.graphicsState"
local polygon = require "components.graphical.polygon"
local trail = require "components.graphical.trail"

local size = 20

createEntity()
  :addComponent(transform, vec(100, 100), nil, nil)
  :addComponent("components.test.spin", 10)
  :addComponent(polygon, "line", {vec(size, 0), vec(0, size), vec(-size, 0), vec(0, -size)})
