-- Colorschemes I like
-- local _monokaish = {
-- 	"sainnhe/sonokai",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.g.sonokai_transparent_background = "1"
-- 		vim.g.sonokai_enable_italic = "1"
-- 		vim.g.sonokai_style = "atlantis"
-- 		vim.cmd.colorscheme("sonokai")
-- 	end,
-- }
--
-- local _catpuccino = {
-- 	"Pocco81/Catppuccino.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.g.catppuccino_style = "dark_catppuccino"
-- 		vim.cmd.colorscheme("catppuccino")
-- 	end,
-- }
--
-- local _tokyonight = {
-- 	"folke/tokyonight.nvim",
-- 	opts = {
-- 		transparent = true,
-- 		styles = {
-- 			sidebars = "transparent",
-- 			floats = "transparent",
-- 		},
-- 	},
-- }

local _ponokai = {
	"shawilly/ponokai",
	priority = 1000,
	config = function()
		vim.g.ponokai_enable_italic = "1"
		vim.cmd.colorscheme("ponokai")
	end,
}

-- local _solarized_osaka = {
-- 	"craftzdog/solarized-osaka.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {},
-- }

return _ponokai
