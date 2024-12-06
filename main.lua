local entities = {}

local entityMeta = {
  __index = {
    draw = function (self)
      for _, comp in ipairs(self.components) do
        if comp.draw then comp:draw() end
      end
    end,
    update = function (self, dt)
      for _, comp in ipairs(self.components) do
        if comp.update then comp:update(dt) end
      end
    end,
    addComponent = function(self, comp, ...)
      if type(comp) == "string" then
        comp = require(comp)
      end
      if type(comp) == "function" then
        comp = comp(...)
      end
      table.insert(self.components, comp)
      comp.entity = self
      if comp.onAdd then comp.onAdd() end
    end,
    removeComponent = function(self, comp)

    end
  }
}

function newEntity()
  local ret = {}
  setmetatable(ret)


end
