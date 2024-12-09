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
			local id
			if type(comp) == "string" then
				id = comp
				comp = require(comp)
			end
			if type(comp) == "function" then
				id = comp
				comp = comp(...)
			end
			comp.id = id
			table.insert(self.components, comp)
			comp.entity = self
			if comp.onAdd then comp.onAdd() end
		end,
		removeComponent = function(self, id)
			for i, v in ipairs(self.components) do
				if v.id == id then
					v:onRemove()
					table.remove(self.components, i)
					break
				end
			end
		end
	}
}

function newEntity()
	local ret = {}
	setmetatable(ret)


end
