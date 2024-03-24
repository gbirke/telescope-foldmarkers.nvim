.PHONY: init lint format

init:
	luarocks install luacheck

lint:
	luacheck lua/
	stylua --config-path ./.stylua.toml --check lua/ 

format:
	stylua --config-path ./.stylua.toml lua/
