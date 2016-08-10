package = 'oo'
version = '0.3-1'
source = {
	url = 'git://github.com/limadm/lua-oo.git',
	tag = '0.3'
}
description = {
	summary = 'Pure Lua OOP with multiple inheritance',
	detailed = 'Prototype-based multiple inheritance with fast type testing.',
	homepage = 'https://github.com/limadm/lua-oo',
	maintainer = 'danielm@tinyhub.tk',
	license = 'MIT/X11'
}
dependencies = {
	'lua >= 5.1, <= 5.3',
}
build = {
	type = 'builtin',
	modules = {
		['oo.init'] = 'init.lua'
	}
}
