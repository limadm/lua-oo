local class = require 'classy'
local c = { class('A1') }
local n = 0
local N = tonumber(arg[1]) or 100

function main()
	for i=2,N do
		c[i] = class('A'..tostring(i), c[i-1])
	end
	
		math.randomseed(111)
	for i=1,N*N do
		local o = c[math.random(N)]()
		for j=1,N do
			if class.is_a(o, c[j]) then
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
