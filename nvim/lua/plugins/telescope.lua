return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		---@diagnostic disable
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>sh", function()
			builtin.help_tags({ path_display = { "truncate", shorten = 3 } })
		end, { desc = "[S]earch [H]elp" })

		vim.keymap.set("n", "<leader>sk", function()
			builtin.keymaps({ path_display = { "truncate", shorten = 3 } })
		end, { desc = "[S]earch [K]eymaps" })

		vim.keymap.set("n", "<leader>ss", function()
			builtin.builtin({ path_display = { "truncate", shorten = 3 } })
		end, { desc = "[S]earch [S]elect Telescope" })

		vim.keymap.set("n", "<leader>sd", function()
			builtin.diagnostics({ path_display = { "truncate", shorten = 3 } })
		end, { desc = "[S]earch [D]iagnostics" })

		vim.keymap.set("n", "<leader>sr", function()
			builtin.resume({ path_display = { "truncate", shorten = 3 } })
		end, { desc = "[S]earch [R]esume" })

		vim.keymap.set("n", "<leader>s.", function()
			builtin.oldfiles({ path_display = { "truncate", shorten = 3 } })
		end, { desc = '[S]earch Recent Files ("." for repeat)' })

		vim.keymap.set("n", "<leader><leader>", function()
			builtin.buffers({ path_display = { "truncate", shorten = 3 } })
		end, { desc = "[ ] Find existing buffers" })

		vim.keymap.set("n", "<leader>sg", function()
			builtin.live_grep({ path_display = { "truncate", shorten = 3 } })
		end, { desc = "[S]earch [G]rep" })

		vim.keymap.set("n", "<leader>sw", function()
			builtin.grep_string({ path_display = { "truncate", shorten = 3 } })
		end, { desc = "[S]earch current [W]ord" })

		vim.keymap.set("n", "<leader>sf", function()
			builtin.find_files({ path_display = { "truncate", shorten = 3 } })
		end, { desc = "[S]earch [F]iles" })

		vim.keymap.set("n", "<leader>shf", function()
			builtin.find_files({ hidden = true, path_display = { "truncate", shorten = 3 } })
		end, { desc = "[S]earch w/ [H]idden [F]iles" })

		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
				path_display = { "truncate", shorten = 3 },
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
				path_display = { "truncate", shorten = 3 },
			})
		end, { desc = "[S]earch [/] in Open Files" })

		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({
				cwd = vim.fn.stdpath("config"),
				path_display = { "truncate", shorten = 3 },
			})
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
