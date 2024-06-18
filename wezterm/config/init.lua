---@diagnostic disable
local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end
---@diagnostic enable

---@type table<string, string>
local palette = require("theme.ponokai.palette")

-- window
config.native_macos_fullscreen_mode = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.80
config.macos_window_background_blur = 22
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

-- cursor
config.cursor_blink_rate = 333
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.default_cursor_style = "BlinkingBlock"

-- launch and cli tools
config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
config.launch_menu = {
	{ label = "Bash", args = { "bash", "-l" } },
	{ label = "Fish", args = { "/opt/homebrew/bin/fish", "-l" } },
	{ label = "Zsh", args = { "zsh", "-l" } },
}

config.automatically_reload_config = true

config.colors = {
	foreground = palette["fg"],
	background = palette["bg0"],
	cursor_bg = palette["fg"],
	cursor_border = palette["fg"],
	cursor_fg = palette["bg0"],
	ansi = {
		palette["bg0"],
		palette["red"],
		palette["green"],
		palette["yellow"],
		palette["orange"],
		palette["purple"],
		palette["blue"],
		palette["fg"],
	},
	brights = {
		palette["bg8"],
		palette["red_700"],
		palette["green_700"],
		palette["yellow_700"],
		palette["orange_700"],
		palette["purple_700"],
		palette["blue_700"],
		palette["fg"],
	},
	indexed = {},
	tab_bar = {
		background = palette["bg0"],
	},
}

-- font
---@type table<string, string>
config.font = wezterm.font({
	family = "JetBrainsMono Nerd Font",
	weight = "DemiBold",
})
config.font_size = 17
config.bold_brightens_ansi_colors = true

-- tab bar
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.status_update_interval = 1000
config.tab_max_width = 60

-- keys
---@type table<string, table<string, string>>
config.keys = require("config.keys")

return config
