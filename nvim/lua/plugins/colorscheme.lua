return {
	{
		"shawilly/ponokai",
		priority = 1000,
		config = function()
			vim.g.ponokai_transparent_background = true
			vim.g.ponokai_enable_italic = "1"
			vim.g.ponokai_style = "default"
			vim.cmd.colorscheme("ponokai")
		end,
	},
	-- {
	-- 	"shawilly/ponokai.nvim",
	-- 	dependencies = { "rktjmp/lush.nvim" },
	-- 	-- dev = true,
	-- 	name = "ponokai",
	-- 	branch = "main",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd("colorscheme ponokai")
	-- 	end,
	-- },
	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({
				enable_tailwind = true,
			})
		end,
	},
}
