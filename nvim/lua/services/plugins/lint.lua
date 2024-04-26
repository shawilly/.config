return {
	{ -- Linting
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				dockerfile = { "hadolint" },
				json = { "jsonlint" },
				markdown = { "vale" },
				text = { "vale" },
				javascript = { "eslint" },
				typescript = { "eslint" },
				typescriptreact = { "eslint" },
				javascriptreact = { "eslint" },
				css = { "stylelint" },
				html = { "stylelint" },
				python = { "flake8" },
			}
			lint.linters_by_ft["dockerfile"] = nil
			lint.linters_by_ft["json"] = nil
			lint.linters_by_ft["markdown"] = nil
			lint.linters_by_ft["text"] = nil
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
