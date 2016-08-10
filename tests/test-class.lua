local class = require 'class'
local cn, c = { 'A1' }, { class('A1') }
local n = 0
local N = tonumber(arg[1]) or 100

function main()
	for i=2,N do
		cn[i] = 'A'..tostring(i)
		c[i] = class(cn[i], cn[i-1])
	end
		
	math.randomseed(111)
	for i=1,N*N do
		local o = c[math.random(N)]()
		for j=1,N do
			if class.istype(o, cn[j]) then
				n = n + 1
			end
		end
	end
end

if pcall(main) then
	print(n, collectgarbage('count'))
else
	os.exit(1)
end
