---@diagnostic disable:lowercase-global

rockspec_format = "3.0"
package = "ulf.ui"
version = "scm-1"
source = {
	url = "https://github.com/lua-ulf/ulf.ui/archive/refs/tags/scm-1.zip",
}

description = {
	summary = "ulf.ui is a ui module for the ULF framework.",
	labels = { "docgen", "neovim", "ulf" },
	homepage = "http://github.com/lua-ulf/ulf.ui",
	license = "MIT",
}

dependencies = {
	"lua >= 5.1",
	"inspect",
}
build = {
	type = "builtin",
	modules = {},
	copy_directories = {},
	platforms = {},
}
test_dependencies = {
	"busted",
	"busted-htest",
	"luacov",
	"luacov-html",
	"luacov-multiple",
	"luacov-console",
	"luafilesystem",
}
test = {
	type = "busted",
}
