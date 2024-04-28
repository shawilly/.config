return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	cmd = { "Alpha" },
	opts = function()
		require("custom.alpha-intro").update_colors()
		local dashboard = require("alpha.themes.dashboard")
		local logo = {
			"                                       ",
			"       ███████████           █████      ██",
			"      ███████████             █████ ",
			"      ████████████████ ███████████ ███   ███████",
			"     ████████████████ ████████████ █████ ██████████████",
			"    ██████████████    █████████████ █████ █████ ████ █████",
			"  ██████████████████████████████████ █████ █████ ████ █████",
			" ██████  ███ █████████████████ ████ █████ █████ ████ ██████",
		}
		local _logo = {
			"      ███████████   ████ █████      ██",
			"     ████████████  ████   █████ ",
			"     ████  ███  ████     ████████ ███   ███████████",
			"    ██████████   █████████  ████████ █████ ██████████████",
			"   ████  ███  ████ ███   ███████ █████ █████ ████ █████",
			" ██████ ███  ████ ████████████ █████ █████ ████ █████",
			"██████ ███████████████ ███n████ █████ █████ ████ ██████",
			"",
		}

		dashboard.section.header.val = logo
		dashboard.section.header.opts.hl = "@alpha.title"
		-- highlight button icon
		local function newButton(...)
			local button = dashboard.button(...)
			button.opts.hl = { { "Special", 0, 4 } }
			return button
		end
		dashboard.section.buttons.val = {
			{
				type = "text",
				val = " ",
				opts = {
					position = "center",
				},
			},
			newButton("f", " " .. " Open file", ":lua require('telescope.builtin').find_files()<CR>"),
			newButton("r", " " .. " Open recent", ":lua require('telescope.builtin').oldfiles()<CR>"),
			newButton("t", " " .. " File tree", ":NvimTreeToggle <CR>"),
			newButton(
				"s",
				" " .. " Search for text",
				":lua require('telescope.builtin').live_grep({initial_mode = 'insert'})<CR>"
			),
			newButton("p", "󰏗 " .. " Plugins", ":Lazy<CR>"),
			newButton("q", "󰗼 " .. " Quit", ":q<CR>"),
		}
		dashboard.opts.layout[3].val = 0
		dashboard.section.footer.val = "Now I will have less distraction.\n- Leonhard Euler"
		dashboard.section.footer.opts.hl = "@alpha.footer"
		table.insert(dashboard.config.layout, 5, {
			type = "padding",
			val = 1,
		})
		return dashboard
	end,
	config = function(_, dashboard)
		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		require("alpha").setup(dashboard.opts)

		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				dashboard.section.buttons.val[1].val = "Loaded " .. stats.count .. " plugins in " .. ms .. "ms 󰗠 "
				dashboard.section.buttons.val[1].opts.hl = "@alpha.header"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
