local M = {}

---@module "luassert.stub"
local stub = require("luassert.stub")

local logger = require("ulf.test.busted.logger")
local log = logger.create({
	color = "blue",
})

local mock = require("luassert.mock")
local uv = vim and vim.uv or require("luv")

local Mocks = {}

---@type {[string]:table|fun()}
local Stubs = {}

local Config = {
	stubs = {
		["io.popen"] = function()
			local s = stub.new(io, "popen")
			s.on_call_with("git rev-parse --show-toplevel 2>/dev/null").returns({
				read = function()
					return "/projects/one"
				end,

				close = function() end,
			})
			Stubs["io.popen"] = s
		end,
		["uv.os_homedir"] = function()
			-- m["os_homedir"].returns("/home/test")
			local s = stub.new(uv, "os_homedir")
			s.returns("/home/test")
			Stubs["uv.os_homedir"] = s
		end,
		-- os_uname = function(m)
		-- 	-- m["os_uname"].returns({
		-- 	-- 	sysname = "Windows_NT",
		-- 	-- })
		-- end,
	},
}

---comment
---@param ... string
M.setup = function(...)
	Mocks:setup(...)
	log["suite.start"].info(string.format("configuring mocks"))

	for sym_name, setup_fn in pairs(Config.stubs) do
		-- log["setup.start"].info(string.format("configuring mock sym uv.%s", sym_name))
		-- log.info(string.format("configuring mock sym uv.%s", sym_name))
		setup_fn()
	end

	-- log["suite.end"].info(string.format("all mocks removed"))
end

---@param ... string
M.tear_down = function(...)
	-- Mocks:tear_down(...)
	--
	for sym_name, stub in pairs(Stubs) do
		-- log["setup.teardown"].info(string.format("reverting stub %s", sym_name))
		stub:revert()
	end
end

Mocks.setup = function(self, ...) end

Mocks.tear_down = function(self, ...) end
return M
