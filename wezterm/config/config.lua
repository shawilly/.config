local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- window
config.native_macos_fullscreen_mode = true
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.60
config.macos_window_background_blur = 22
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- cursor
config.cursor_blink_rate = 100
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- launch and cli tools
config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
local launch_menu = {
	{ label = "Bash", args = { "bash", "-l" } },
	{ label = "Fish", args = { "/opt/homebrew/bin/fish", "-l" } },
	{ label = "Nushell", args = { "/opt/homebrew/bin/nu", "-l" } },
	{ label = "Zsh", args = { "zsh", "-l" } },
	{ label = "Pwsh", args = { "/usr/local/bin/pwsh", "-NoLogo" } },
}
config.launch_menu = launch_menu
config.automatically_reload_config = true

-- colour
config.color_scheme = "Catppuccin Mocha"

-- font
config.font = wezterm.font({
	family = "JetBrainsMono Nerd Font",
	weight = "DemiBold",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.font_size = 17
config.bold_brightens_ansi_colors = true

-- tab bar
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.status_update_interval = 1000

-- keys
config.keys = require("config.keys")

return config
