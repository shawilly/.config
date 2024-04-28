if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

require("custom.minintro")
require("services.health")
require("services.plugins.debug")
require("services.plugins.indent_line")
require("services.plugins.lint")
require("config.lazy")
