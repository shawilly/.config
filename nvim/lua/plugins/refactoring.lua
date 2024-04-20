return {
	-- Incremental rename
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		keys = {
			{
				"<leader>rn",
				function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end,
				desc = "Incremental rename",
				mode = "n",
				noremap = true,
				expr = true,
			},
		},
		config = true,
	},

	-- Refactoring tool
	{
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>r",
				function()
					require("refactoring").select_refactor({
						show_success_message = true,
					})
				end,
				mode = "v",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
		opts = {},
	},

	--Formatter
	{ -- Formatter
		"stevearc/conform.nvim",
		lazy = false,

		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = true,
			formatters_by_ft = {
				lua = { "stylua" },
				typescript = { { "prettier", "prettierd" } },
				typescriptreact = { { "prettier", "prettierd" } },
				javascript = { { "prettier", "prettierd" } },
				javascriptreact = { { "prettier", "prettierd" } },
				json = { { "prettier", "prettierd" } },
				html = { { "prettier", "prettierd" } },
				css = { { "prettier", "prettierd" } },
				python = { "isort", "black" },
			},
		},
	},
}
