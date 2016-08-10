Pure Lua classes with multiple inheritance.
===========================================

Use `T = Base:extend(Mixin1, Mixin2, ...)` to create subclasses,
`T()` or `T{attribute1=1, attribute2=2, ...}` to create instances,
and `object:is_a(MyClass)` to test instance typing. Mixins can be
other classes or plain Lua tables, their attributes are shallowly
copied to the new class. Initializers are optional and defined by
an `__init` function, and you can access the superclass of an 
instance with `object.super`.

Note that you can change attributes and methods after subclassing,
and it is possible inherit from instances (prototypes a la JS).
Also, `object.super` is there for convenience only and can be 
overwritten if used for something else.

Example usage:

```
	class = require 'oo'

	Product = class()
	Product.name = 'Generic Product'
	function Product:print()
		print(self.name)
	end

	Automobile = Product:extend {
		fueled = true,
		wheels = 4,
		__init = function(self)
			self.name = 'Automobile: '..self.name
		end
	}
	a = Automobile()
	a:print()  -- Automobile: Generic Product

	Bicycle = Product:extend()
	Bicycle.wheels = 2
	function Bicycle:__init()
		self.name = 'Bicycle: '..self.name
	end
	function Bicycle:print()
		self.super.print(self)
		print('Wheels: ', self.wheels)
	end
	b = Bicycle{ name='Houston MTB' }
	b:print()  -- Bicycle: Houston MTB\nWheels: 2

	Motorcycle = Automobile:extend(Bicycle)
	c = Motorcycle{ name='Honda CG 200' }
	c:print()  -- Automobile: Honda CG 200\nWheels: 2
	= c.fueled -- true

	= a:is_a(Product)       -- true
	= a:is_a(Automobile)    -- true
	= a:is_a(Bicycle)       -- false
	= a:is_a(Motorcycle)    -- false

	= b:is_a(Product)      -- true
	= b:is_a(Automobile)   -- false
	= b:is_a(Bicycle)      -- true
	= b:is_a(Motorcycle)   -- false

	= c:is_a(Product)     -- true
	= c:is_a(Automobile)  -- true
	= c:is_a(Bicycle)     -- true
	= c:is_a(Motorcycle)  -- true
```

There are other interesting alternatives in luarocks, so I have
microbenchmarked them all. This test does NOT represent an 
real-world class hierarchy, but helps to compare some of the
library overhead and therefore helped me to improve lua-oo.
Anyway, the test is something like:

```
local class = require 'oo'
local n = 0
local N = 100

-- create a base class
local c = { class() }

--create a deep chain of subclasses
for i=2,N do
	c[i] = c[i-1]:extend()
end

--create many random objects and count instances of all classes
for i=1,N*N do
	local obj = c[math.random(N)]()
	for j=1,N do
		if obj:is_a(c[j]) then
			n = n + 1
		end
	end
end

print(n, collectgarbage('count'))
```

The results (ran on a Core2 P8600, with luajit-2.1.0-beta2):

Memory usage, as reported by `garbagecollect('count')`:

![Memory usage (KB)](https://github.com/limadm/lua-oo/raw/master/tests/plots/mem.png)

CPU user time, as reported by `time -p ...`.  
Note: I ignored system time to see what is running in Lua side
without allocation, I/O and context switches.

![CPU time (s)](https://github.com/limadm/lua-oo/raw/master/tests/plots/cpu.png)

Oops crashed for N >= 200, and middleclass took more than 1h for
N >= 400, so they were out of these instances.

---

MIT/X license (c) 2016 Daniel Lima
