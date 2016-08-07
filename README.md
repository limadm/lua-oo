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

---

MIT/X license (c) 2016 Daniel Lima
