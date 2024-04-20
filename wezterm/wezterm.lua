local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

local config = {}
local mouse_bindings = {}
local launch_menu = {}

local haswork, work = pcall(require, "work")

local keys = {
	-- copy and paste from the standard register
	{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
	-- tabs
	{ key = "t", mods = "SUPER", action = act.SpawnTab("DefaultDomain") },
	-- tabs: navigation
	{ key = "[", mods = "SUPER", action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "SUPER", action = act.ActivateTabRelative(1) },
	{ key = "[", mods = "SUPER|CTRL", action = act.MoveTabRelative(-1) },
	{ key = "]", mods = "SUPER|CTRL", action = act.MoveTabRelative(1) },
}

table.insert(launch_menu, {
	label = "Pwsh",
	args = { "/usr/local/bin/pwsh", "-NoLogo" },
})

config.color_scheme_dirs = { "../../wezterm-dracula/dracula.toml" }
config.color_scheme = "Dracula (Official)"

config.font = wezterm.font("Hurmit Nerd Font", { weight = "Bold" })
config.font_size = 18

config.launch_menu = launch_menu
config.keys = keys
config.mouse_bindings = mouse_bindings

config.use_fancy_tab_bar = false
config.automatically_reload_config = true

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local palette = config.resolved_palette.tab_bar
	local colors = {
		bg = palette.background,
		tab = tab.is_active and palette.active_tab.bg_color or palette.inactive_tab.bg_color,
		fg = tab.is_active and palette.active_tab.fg_color or palette.inactive_tab.fg_color,
	}

	return {
		{ Background = { Color = colors.bg } },
		{ Foreground = { Color = colors.tab } },
		{ Text = wezterm.nerdfonts.ple_lower_right_triangle },
		{ Background = { Color = colors.tab } },
		{ Foreground = { Color = colors.fg } },
		{ Text = tab.active_pane.title },
		{ Background = { Color = colors.tab } },
		{ Foreground = { Color = colors.bg } },
		{ Text = wezterm.nerdfonts.ple_upper_right_triangle },
	}
end)

wezterm.on("update-right-status", function(window, pane)
	-- "Wed Mar 3 08:14"
	local date = wezterm.strftime("%a %b %-d %H:%M ")

	local bat = ""
	for _, b in ipairs(wezterm.battery_info()) do
		bat = "🔋 " .. string.format("%.0f%%", b.state_of_charge * 100)
	end

	window:set_right_status(wezterm.format({
		{ Text = bat .. "   " .. date },
	}))
end)

return config
