local intros = require("custom.intro")
local basic_intro = intros.basic_intro

local highlight_colors = {
	"#48cae4",
	"#00b4d8",
	"#0096c7",
	"#0077b6",
	"#ffd500",
	"#fdc500",
	"#eae2b7",
}

local highlight_groups = {
	"NeovimDashboardLogo1",
	"NeovimDashboardLogo2",
	"NeovimDashboardLogo3",
	"NeovimDashboardLogo4",
	"NeovimDashboardLogo5",
	"NeovimDashboardLogo6",
	"NeovimDashboardLogo7",
}

local get_gradient_header = function()
	for i, hl_group in ipairs(highlight_groups) do
		vim.api.nvim_set_hl(0, hl_group, { fg = highlight_colors[i] })
	end

	local gradient_header = {}
	for i, line in ipairs(basic_intro) do
		table.insert(gradient_header, {
			type = "text",
			val = line,
			opts = { hl = highlight_groups[i], shrink_margin = false, position = "center" },
		})
	end

	local output = {
		type = "group",
		val = gradient_header,
		opts = { position = "center" },
	}

	return output
end

local function configure()
	local d_ok, dashboard = pcall(require, "alpha.themes.dashboard")
	if not d_ok then
		print("Failed to load alpha.themes.dashboard")
		return
	end

	local ok, theta = pcall(require, "alpha.themes.theta")
	if not ok then
		print("Failed to load alpha.themes.theta")
		return
	end

	theta.config.layout[2] = get_gradient_header()

	theta.config.layout[6] = {
		type = "group",
		val = {
			{ type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
			{ type = "padding", val = 1 },
			dashboard.button("␣  t", "ᨒ↟ Tree"),
			dashboard.button("␣ sf", "  Find file"),
			dashboard.button("␣ sg", "  Find text"),
			dashboard.button("   e", "  New file", "<cmd>ene<CR>"),
			dashboard.button("   u", "󱐥  Update plugins", "<cmd>Lazy sync<CR>"),
			dashboard.button("   t", "  Install language tools", "<cmd>Mason<CR>"),
			dashboard.button("   q", "󰩈  Quit", "<cmd>qa<CR>"),
		},
		position = "center",
	}

	return theta.config
end

return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		require("alpha").setup(configure())
	end,
}
