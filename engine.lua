local entities = {}

local function event(name)
  return function (self, ...)
			for _, comp in ipairs(self.components) do
				if comp[name] then comp[name](comp, ...) end
			end
  end
end

local function eventReverse(name)
  return function (self, ...)
			for i = #self.components, 1, -1 do
        local comp = self.components[i]
				if comp[name] then comp[name](comp, ...) end
			end
  end
end

local entityMeta = {
	__index = {
		draw = event "draw",
		update = event "update",
    postDraw = eventReverse "postDraw",
    postDrawScene = eventReverse "postDrawScene",
    postUpdate = eventReverse "postUpdate",
    postUpdateScene = eventReverse "postUpdateScene",


		addComponent = function(self, comp, ...)
			local source
			if type(comp) == "string" then
				comp = require(comp)
			end
			if type(comp) == "function" then
				comp = comp(...)
			end
			table.insert(self.components, comp)
			comp.entity = self
			if comp.onAdd then comp:onAdd() end
      if not checkDeps(comp) then
        self:removeComponent(comp)
      end
      return self
		end,
		removeComponent = function(self, source)
			for i, v in ipairs(self.components) do
				if v == source or v.name == source then
					v:onRemove()
					table.remove(self.components, i)
          for _, comp in ipairs(self.components) do
            if not checkDeps(comp) then
              self:removeComponent(comp)
            end
          end
					break
				end
			end
      return self
		end,
    getComponent = function(self, source)
			for i, v in ipairs(self.components) do
				if v.name == source then
          return v, i
				end
			end
      return self
    end
	}
}

function checkDeps(self)
  for _, dep in ipairs(self.deps or {}) do
    local fail = false
    local comp = self.entity:getComponent(dep)
    if not comp then
      warn("attempted to add component ", self.name, "(", self.id, ") to an entity without '", dep, "'")
      fail = true
    end
  end
  return not fail
end

function component(props)

  local mt = {
    __index = props
  }

  assert(props.name, "Component does not have a name")

  for k, v in pairs(props) do
    if k:sub(1, 2) == "__" then
      if k == "__index" then
        function mt:__index(key)
          return props[key] or v(self, key)
        end
      else
        mt[k] = v
      end
    end
  end

  return function (...)
    local ret = setmetatable({}, mt)
    ret:ctor(...)
    print(ret, ret.name)
    return ret
  end
end

function newEntity()
	local ret = {components = {}}
	setmetatable(ret, entityMeta)
  return ret

end

function createEntity()
  local ret = newEntity()
  table.insert(entities, ret)
  return ret
end

function love.draw()
  for _, entity in ipairs(entities) do
    entity:draw()
    entity:postDraw()
  end
  for i = #entities, 1, -1 do
    entities[i]:postDrawScene()
  end
end

function love.update(dt)
  for _, entity in ipairs(entities) do
    entity:update(dt)
    entity:postUpdate(dt)
  end
  for i = #entities, 1, -1 do
    entities[i]:postUpdateScene(dt)
  end
end
