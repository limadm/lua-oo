-- Contributed by github.com/winterwolf

local oo = require "oo"

local Creature = oo()
Creature.__call = function() print("Creature was called!") end
local Animal = oo(Creature)
local Cat = oo(Animal)

local blu = Creature()
print(blu)
print(pcall(blu))
print('is blu creatur?', blu:is(Creature))
print('is blu animal?',  blu:is(Animal))
print('is blu cat?',     blu:is(Cat))
print()

local kin = Animal()
print(kin)
print(pcall(kin))
print('is kin creatur?', kin:is(Creature))
print('is kin animal?',  kin:is(Animal))
print('is kin cat?',     kin:is(Cat))
print()

local tom = Cat()
print(tom) -- table
print(pcall(tom)) -- error (attempt to call a table value)
print('is tom creatur?', tom:is(Creature))
print('is tom animal?',  tom:is(Animal))
print('is tom cat?',     tom:is(Cat))
