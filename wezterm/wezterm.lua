require("utils.backdrops"):set_files():choices()

local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

config.native_macos_fullscreen_mode = true

-- window
local show_window_title = false

config.window_decorations = show_window_title and "TITLE | RESIZE" or "RESIZE"

-- background
local backdrops = require("utils.backdrops")
config.window_background_opacity = 0.6
config.macos_window_background_blur = 20

-- launch and cli tools
config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
local launch_menu = {
	{ label = "Bash", args = { "bash", "-l" } },
	{ label = "Fish", args = { "/opt/homebrew/bin/fish", "-l" } },
	{ label = "Nushell", args = { "/opt/homebrew/bin/nu", "-l" } },
	{ label = "Zsh", args = { "zsh", "-l" } },
}
config.launch_menu = launch_menu
table.insert(launch_menu, {
	label = "Pwsh",
	args = { "/usr/local/bin/pwsh", "-NoLogo" },
})

config.launch_menu = launch_menu
config.automatically_reload_config = true

-- colour
config.color_scheme = "Catppuccin Mocha"

-- font
config.font = wezterm.font({
	family = "SauceCodePro Nerd Font",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.font_size = 14
config.bold_brightens_ansi_colors = true

-- tab bar
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.status_update_interval = 1000

wezterm.on("update-status", function(window, pane)
	local moon = "🌕"
	local battery = wezterm.nerdfonts.fa_battery
	local charge_percent = ""
	local state_suffix = ""
	local charge_color = "#B8E6C9"

	for _, b in ipairs(wezterm.battery_info()) do
		if b.state_of_charge < 0.2 then
			moon = "🌑"
			battery = wezterm.nerdfonts.fa_battery_0
			charge_color = "#F3B0A7"
		elseif b.state_of_charge < 0.4 then
			moon = "🌘"
			battery = wezterm.nerdfonts.fa_battery_1
			charge_color = "#FFDAB9"
		elseif b.state_of_charge < 0.6 then
			moon = "🌗"
			battery = wezterm.nerdfonts.fa_battery_2
			charge_color = "#F5F5B8"
		elseif b.state_of_charge < 0.8 then
			moon = "🌖"
			battery = wezterm.nerdfonts.fa_battery_3
			charge_color = "#D0E68D"
		end

		-- Display charging or discharging state
		if b.state == "Charging" then
			state_suffix = wezterm.nerdfonts.fa_plug -- Lightning bolt icon for charging
			if b.time_to_full then
				state_suffix = state_suffix .. " " .. math.ceil(b.time_to_full / 60) .. "m"
			end
		elseif b.state == "Discharging" then
			if b.time_to_empty then
				state_suffix = " " .. math.ceil(b.time_to_empty / 60) .. "m"
			end
		end

		charge_percent = string.format("%.0f%%", b.state_of_charge * 100)
	end

	-- Time
	local time = wezterm.strftime("%H:%M")

	-- Left status (left of the tab line)
	window:set_left_status(wezterm.format({
		{ Foreground = { Color = "#FFBBDD" } },
		{ Text = " do it for them <3 " },
		{ Text = "   " },
		{ Text = moon },
		{ Text = "   " },
	}))

	-- Current working directory
	local basename = function(s)
		-- Nothing a little regex can't fix
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
		-- return s
	end

	-- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l). Not a big deal, but check in case
	local cwd = pane:get_current_working_dir()
	cwd = basename(cwd.path) or ""
	-- Current command
	local cmd = basename(pane:get_foreground_process_name()) or ""

	-- Right status
	window:set_right_status(wezterm.format({
		{ Foreground = { Color = "#AAAAFF" } },
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		"ResetAttributes",
		{ Text = " | " },
		{ Foreground = { Color = "#e0af68" } },
		{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
		"ResetAttributes",
		{ Text = " | " },
		{ Foreground = { Color = charge_color } },
		{ Text = state_suffix .. " " },
		{ Text = charge_percent .. " " },
		"ResetAttributes",
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_clock .. "  " .. time },
		{ Text = "  " },
	}))
end)

-- Allow zen mode to adjust font size and zoom level
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

-- mouse (yuck)
local mouse_bindings = {}
config.mouse_bindings = mouse_bindings

-- keys (yay)
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
	{
		key = [[/]],
		mods = "SUPER|CTRL",
		action = act.InputSelector({
			title = "Select Background",
			choices = backdrops:choices(),
			fuzzy = true,
			fuzzy_description = "Select Background: ",
			action = wezterm.action_callback(function(window, _pane, idx)
				---@diagnostic disable-next-line: param-type-mismatch
				backdrops:set_img(window, tonumber(idx))
			end),
		}),
	},
	{
		key = "r",
		mods = "SUPER|SHIFT",
		action = wezterm.action.ReloadConfiguration,
	},
	{
		key = "w",
		mods = "SUPER|SHIFT",
		action = wezterm.action_callback(function(show_window_title)
			show_window_title = not show_window_title
			if show_window_title then
				config.window_decorations = "TITLE | RESIZE"
			else
				config.window_decorations = "RESIZE"
			end
		end),
	},
}
config.keys = keys

return config
