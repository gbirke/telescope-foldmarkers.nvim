.PHONY: lint format

init:
	luarocks install luacheck

lint:
	luacheck lua/

format:
	stylua lua/ --config-path ./.stylua.toml
