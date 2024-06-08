return {
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {
	-- 		transparent = false,
	-- 	},
	-- },
	{
		"shawilly/ponokai",
		priority = 1000,
		config = function()
			vim.g.ponokai_enable_italic = "1"
			vim.cmd.colorscheme("ponokai")
		end,
	},
}
