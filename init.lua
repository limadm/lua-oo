-- Pure Lua classes with multiple inheritance.
-- MIT/X license (c) 2016 Daniel Lima

-- Create an instance of self
local function new(self, prototype)
	local obj = setmetatable(prototype or {}, self)
	obj:__init()
	return obj
end

local root = {
	__init = function() end,
}
local types = {
	[root] = {},
}

-- Create a new subclass of the 'base' class,
-- passing several tables as mixins for multiple inheritance.
-- In case of conflicting attributes, the last mixin will resolve.
local function extend(base,...)
	-- T is the new subclass of self
	local T = {
		__init = base.__init, --default initializer
	}
	-- superclasses of T
	types[T] = { [T]=true }
	for t in pairs(types[base]) do
		types[T][t] = true
	end
	-- copy mixins to T
	for _,m in ipairs{...} do
		types[T][m] = true
		for k,v in pairs(m) do
			T[k] = v
		end
	end
	-- link methods
	T.super   = base
	T.extend  = extend
	T.__index = T
	-- test if object is an instance of class (or any subclass)
	function T:is_a(class)
		return types[T][class]
	end
	local Tmt = {
		__call  = new,
		__index = base
	}
	return setmetatable(T, Tmt)
end

-- alias to class creation
local function class(...)
	return extend(root,...)
end

-- shallow table copying
local function copy(self)
	local t = {}
	for k,v in pairs(self) do
		t[k] = v
	end
	return setmetatable(t, getmetatable(self))
end

-- deep table copying (beware: does not treat reference loops)
local function deepcopy(self)
	if type(self) == 'table' then
		local t = {}
		for k,v in pairs(self) do
			t[k] = deepcopy(v)
		end
		return setmetatable(t, getmetatable(self))
	end
	return self
end

return setmetatable({
	copy = copy,
	class = class,
	deepcopy = deepcopy,
}, { __call = class })
