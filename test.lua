-- About as fast as torch/class

local class = require 'init'
local classes = {}
local n = 0
local N = 1000

local c = class()

for i=1,N do
	c = c:extend()
	table.insert(classes, c)
end

for i=1,N*N do
	local obj = classes[math.random(N)]()
	for j=1,N do
		if obj:is_a(classes[j]) then
			n = n + 1
		end
	end
end
print(n)
