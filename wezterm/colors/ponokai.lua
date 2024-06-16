local palette = require("theme.ponokai.palette")

return {
	color_schemes = {
		["Ponokai"] = {
			foreground = "#fdf9f3",
			background = "#363537",
			cursor_bg = "#fdf9f3",
			cursor_border = "#fdf9f3",
			cursor_fg = "#363537",
			ansi = {
				palette["bg0"],
				"#ff6188",
				"#a9dc76",
				"#ffd866",
				"#fc9867",
				"#ab9df2",
				"#78dce8",
				"#fdf9f3",
			},
			brights = {
				"#908e8f",
				"#ff6188",
				"#a9dc76",
				"#ffd866",
				"#fc9867",
				"#ab9df2",
				"#78dce8",
				"#fdf9f3",
			},
			indexed = {},
		},
	},
	color_scheme = "Ponokai",
	metadata = {
		name = "Monokai Pro (Gogh)",
		origin_url = "https://github.com/Gogh-Co/Gogh",
	},
}
