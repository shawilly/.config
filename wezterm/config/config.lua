local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- window
config.native_macos_fullscreen_mode = true
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity = 0.60
config.macos_window_background_blur = 22
config.window_padding = {
	left = "0cell",
	right = 0,
	top = "0.8cell",
	bottom = "0cell",
}

-- cursor
config.cursor_blink_rate = 100
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- keys
config.keys = require("config.keys")

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
local custom = wezterm.color.get_builtin_schemes()["Catppuccin Macchiato"]
config.color_schemes = {
	["OLEDppuccin"] = custom,
}
config.color_scheme = "OLEDppuccin"

-- font
config.font = wezterm.font({
	family = "JetBrainsMono Nerd Font",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.font_size = 16
config.bold_brightens_ansi_colors = true

-- tab bar
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.status_update_interval = 1000

return config