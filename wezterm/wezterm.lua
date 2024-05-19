require("utils.backdrops"):set_files():choices()

local wezterm = require("wezterm")
local act = wezterm.action
local nf = wezterm.nerdfonts

-- Functions
local get_last_folder_segment = function(cwd)
	if cwd == nil then
		return "N/A" -- or some default value you prefer
	end

	-- Strip off 'file:///' if present
	local pathStripped = cwd:match("^file:///(.+)") or cwd
	-- Normalize backslashes to slashes for Windows paths
	pathStripped = pathStripped:gsub("\\", "/")
	-- Split the path by '/'
	local path = {}
	for segment in string.gmatch(pathStripped, "[^/]+") do
		table.insert(path, segment)
	end
	return path[#path] -- returns the last segment
end

local function get_current_working_dir(tab)
	local current_dir = tab.active_pane.current_working_dir or ""
	return get_last_folder_segment(current_dir)
end

local process_icons = {
	["docker"] = nf.linux_docker,
	["docker-compose"] = nf.linux_docker,
	["psql"] = nf.dev_postgresql,
	["kuberlr"] = nf.linux_docker,
	["kubectl"] = nf.linux_docker,
	["stern"] = nf.linux_docker,
	["nvim"] = nf.custom_vim,
	["make"] = nf.seti_makefile,
	["vim"] = nf.dev_vim,
	["go"] = nf.seti_go,
	["zsh"] = nf.dev_terminal,
	["bash"] = nf.cod_terminal_bash,
	["btm"] = nf.mdi_chart_donut_variant,
	["htop"] = nf.mdi_chart_donut_variant,
	["cargo"] = nf.dev_rust,
	["sudo"] = nf.fa_hashtag,
	["lazydocker"] = nf.linux_docker,
	["git"] = nf.dev_git,
	["lua"] = nf.seti_lua,
	["wget"] = nf.mdi_arrow_down_box,
	["curl"] = nf.mdi_flattr,
	["gh"] = nf.dev_github_badge,
	["ruby"] = nf.cod_ruby,
	["pwsh"] = nf.seti_powershell,
	["node"] = nf.dev_nodejs_small,
	["dotnet"] = nf.md_language_csharp,
	["fish"] = nf.md_fish .. nf.fa_terminal,
}

local function get_process(tab)
	local process_name = tab.active_pane.foreground_process_name:match("([^/\\]+)%.exe$")
		or tab.active_pane.foreground_process_name:match("([^/\\]+)$")

	-- local icon = process_icons[process_name] or string.format('[%s]', process_name)
	local icon = process_icons[process_name] or nf.seti_checkbox_unchecked

	return icon
end

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.native_macos_fullscreen_mode = true

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

-- background
local backdrops = require("utils.backdrops")
config.window_background_opacity = 0.60
config.macos_window_background_blur = 22
config.window_padding = {
	top = 55,
	right = 5,
	bottom = 0,
	left = 5,
}

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
config.color_scheme = "Catppuccino Dark"

-- font
config.font = wezterm.font({
	family = "JetBrainsMono Nerd Font",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.font_size = 14
config.bold_brightens_ansi_colors = true

-- tab bar
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.status_update_interval = 1000
config.tab_max_width = 60

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local has_unseen_output = false
	local is_zoomed = false

	for _, pane in ipairs(tab.panes) do
		if not tab.is_active and pane.has_unseen_output then
			has_unseen_output = true
		end
		if pane.is_zoomed then
			is_zoomed = true
		end
	end

	local cwd = get_current_working_dir(tab)
	local process = get_process(tab)
	local zoom_icon = is_zoomed and nf.cod_zoom_in or ""
	local title = string.format(" %s ~ %s %s ", process, cwd, zoom_icon) -- Add placeholder for zoom_icon

	return wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Text = title },
	})
end)

wezterm.on("update-status", function(window, pane)
	local moon = nf.weather_moon_full
	local battery = nf.md_battery_heart
	local charge_color = "lightgreen"
	local charge_percent = ""
	local state_suffix = ""

	for _, b in ipairs(wezterm.battery_info()) do
		charge_percent = string.format("%.0f%%", b.state_of_charge * 100)

		if b.state_of_charge < 0.2 then
			moon = nf.weather_moon_waning_crescent_2
			battery = nf.md_battery_alert_variant_outline
			charge_color = "#F3B0A7"
		elseif b.state_of_charge < 0.4 then
			moon = nf.weather_moon_waning_crescent_1
			battery = nf.md_battery_40
			charge_color = "#FFDAB9"
		elseif b.state_of_charge < 0.6 then
			moon = nf.weather_moon_waning_gibbous_2
			battery = nf.md_battery_60
			charge_color = "#F5F5B8"
		elseif b.state_of_charge < 0.8 then
			charge_color = "#B8E6C9"
			moon = nf.weather_moon_waning_gibbous_1
			battery = nf.md_battery_80
		else
			moon = nf.weather_moon_full
			battery = nf.md_battery_heart
		end

		-- Display charging or discharging state
		if b.state == "Charging" then
			if b.time_to_full then
				state_suffix = state_suffix .. " " .. math.ceil(b.time_to_full / 60) .. "m"
			end
		elseif b.state == "Discharging" then
			if b.time_to_empty then
				state_suffix = math.ceil(b.time_to_empty / 60) .. "m"
			end
		end

		-- Time
		local time = wezterm.strftime("%H:%M")

		-- Left status (left of the tab line)
		window:set_left_status(wezterm.format({
			{ Foreground = { Color = "#FFBBDD" } },
			{ Text = "do it for them  " .. nf.md_heart },
			{ Text = " " },
			{ Text = moon },
			{ Text = "  " },
		}))

		-- Current working directory
		local basename = function(s)
			return string.gsub(s, "(.*[/\\])(.*)", "%2")
		end

		-- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l). Not a big deal, but check in case
		local cwd = pane:get_current_working_dir()
		cwd = basename(cwd.path) or ""
		-- Current command
		local cmd = basename(pane:get_foreground_process_name()) or ""
		local cmd_icon = process_icons[cmd] or nf.fa_terminal

		-- Right status
		window:set_right_status(wezterm.format({
			{ Foreground = { Color = "#AAAAFF" } },
			{ Text = nf.md_folder .. " " .. cwd },
			"ResetAttributes",
			{ Text = " | " },
			{ Foreground = { Color = "#e0af68" } },
			{ Text = cmd_icon .. "  " .. cmd },
			"ResetAttributes",
			{ Text = " | " },
			{ Foreground = { Color = charge_color } },
			{ Text = battery .. " " },
			{ Text = charge_percent .. " " },
			{ Text = state_suffix },
			"ResetAttributes",
			{ Text = " | " },
			{ Text = nf.md_clock .. "  " .. time },
			{ Text = "  " },
		}))
	end
end)

-- on user-var-changed
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

-- keys
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
		key = "t",
		mods = "SUPER|SHIFT",
		action = wezterm.action_callback(function(show_window_title)
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
