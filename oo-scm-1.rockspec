package = 'oo'
version = 'scm-1'
source = {
	url = '.'
}
description = {
	summary = 'Pure Lua classes with multiple inheritance',
	detailed = [[
		Prototype-based multiple inheritance with fast type testing.
		No method overloading thou.
	]],
	homepage = 'https://github.com/limadm/lua-class',
	license = 'MIT/X11'
}
dependencies = {
	'lua >= 5.1, <= 5.3',
}
build = {
	type = 'builtin',
	modules = {
		['oo'] = 'oo.lua'
	}
}
