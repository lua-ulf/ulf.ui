local function lazy_require(module)
	return setmetatable({}, {
		__class = { name = "lazy_require", module = "ulf.ui" },
		__index = function(m, k)
			return function(...)
				return require(module)[k](...)
			end
		end,
	})
end
---@module "ulf.ui.debug""
local _text = lazy_require("ulf.ui.text")

---@class ulf.ui : ulf.package.Package
---@field text ulf.ui.text
local M = {

	meta = require("ulf.ui.package"),
	config = {},
	text = _text,
}

return M
