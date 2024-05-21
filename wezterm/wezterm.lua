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
	left = "0cell",
	right = 0,
	top = "0.8cell",
	bottom = "0cell",
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
config.font_size = 8.5
config.bold_brightens_ansi_colors = true

-- tab bar
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.status_update_interval = 1000

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local SOLID_LEFT_ARROW = utf8.char(0xe0ba)
local SOLID_LEFT_MOST = utf8.char(0x2588)
local SOLID_RIGHT_ARROW = utf8.char(0xe0bc)

local ADMIN_ICON = utf8.char(0xf49c)

local CMD_ICON = utf8.char(0xe62a)
local NU_ICON = utf8.char(0xe7a8)
local PS_ICON = utf8.char(0xe70f)
local ELV_ICON = utf8.char(0xfc6f)
local WSL_ICON = utf8.char(0xf83c)
local YORI_ICON = utf8.char(0xf1d4)
local NYA_ICON = utf8.char(0xf61a)

local VIM_ICON = utf8.char(0xe62b)
local PAGER_ICON = utf8.char(0xf718)
local FUZZY_ICON = utf8.char(0xf0b0)
local HOURGLASS_ICON = utf8.char(0xf252)
local SUNGLASS_ICON = utf8.char(0xf9df)

local PYTHON_ICON = utf8.char(0xf820)
local NODE_ICON = utf8.char(0xe74e)
local DENO_ICON = utf8.char(0xe628)
local LAMBDA_ICON = utf8.char(0xfb26)
local MONGO_ICON = nf.dev_mongodb
local FISH_ICON = nf.md_fish .. nf.fa_terminal
local SSH_ICON = nf.md_ssh

local SUP_IDX = {
	"¹",
	"²",
	"³",
	"⁴",
	"⁵",
	"⁶",
	"⁷",
	"⁸",
	"⁹",
	"¹⁰",
	"¹¹",
	"¹²",
	"¹³",
	"¹⁴",
	"¹⁵",
	"¹⁶",
	"¹⁷",
	"¹⁸",
	"¹⁹",
	"²⁰",
}
local SUB_IDX = {
	"₁",
	"₂",
	"₃",
	"₄",
	"₅",
	"₆",
	"₇",
	"₈",
	"₉",
	"₁₀",
	"₁₁",
	"₁₂",
	"₁₃",
	"₁₄",
	"₁₅",
	"₁₆",
	"₁₇",
	"₁₈",
	"₁₉",
	"₂₀",
}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local process_name = tab.active_pane.foreground_process_name
	local pane_title = tab.active_pane.title
	local exec_name = basename(process_name):gsub("%.exe$", "")
	local title_with_icon

	if exec_name == "nu" then
		title_with_icon = NU_ICON .. " NuShell"
	elseif exec_name == "pwsh" then
		title_with_icon = PS_ICON .. " PS"
	elseif exec_name == "cmd" then
		title_with_icon = CMD_ICON .. " CMD"
	elseif exec_name == "elvish" then
		title_with_icon = ELV_ICON .. " Elvish"
	elseif exec_name == "wsl" or exec_name == "wslhost" then
		title_with_icon = WSL_ICON .. " WSL"
	elseif exec_name == "nyagos" then
		title_with_icon = NYA_ICON .. " " .. pane_title:gsub(".*: (.+) %- .+", "%1")
	elseif exec_name == "yori" then
		title_with_icon = YORI_ICON .. " " .. pane_title:gsub(" %- Yori", "")
	elseif exec_name == "nvim" then
		title_with_icon = VIM_ICON .. " " .. pane_title:gsub("^(%S+)%s+(%d+/%d+) %- nvim", " %2 %1")
	elseif exec_name == "bat" or exec_name == "less" or exec_name == "moar" then
		title_with_icon = PAGER_ICON .. " " .. exec_name:upper()
	elseif exec_name == "fzf" or exec_name == "hs" or exec_name == "peco" then
		title_with_icon = FUZZY_ICON .. " " .. exec_name:upper()
	elseif exec_name == "btm" or exec_name == "ntop" then
		title_with_icon = SUNGLASS_ICON .. " " .. exec_name:upper()
	elseif exec_name == "python" or exec_name == "hiss" then
		title_with_icon = PYTHON_ICON .. " " .. exec_name
	elseif exec_name == "node" then
		title_with_icon = NODE_ICON .. " " .. exec_name:upper()
	elseif exec_name == "deno" then
		title_with_icon = DENO_ICON .. " " .. exec_name:upper()
	elseif exec_name == "bb" or exec_name == "cmd-clj" or exec_name == "janet" or exec_name == "hy" then
		title_with_icon = LAMBDA_ICON .. " " .. exec_name:gsub("bb", "Babashka"):gsub("cmd%-clj", "Clojure")
	elseif exec_name == "mongo" then
		title_with_icon = MONGO_ICON .. " " .. exec_name
	elseif exec_name == "fish" then
		title_with_icon = FISH_ICON .. " " .. pane_title:gsub("~/", "")
	elseif exec_name == "ssh" then
		title_with_icon = SSH_ICON
	elseif exec_name == "bash" then
		title_with_icon = process_icons[exec_name] .. " " .. pane_title:gsub("~/", "")
	else
		title_with_icon = HOURGLASS_ICON .. " " .. exec_name
	end
	if pane_title:match("^Administrator: ") then
		title_with_icon = title_with_icon .. "  " .. ADMIN_ICON
	end
	local left_arrow = SOLID_LEFT_ARROW
	if tab.tab_index == 0 then
		left_arrow = SOLID_LEFT_MOST
	end
	local id = SUB_IDX[tab.tab_index + 1]
	local pid = SUP_IDX[tab.active_pane.pane_index + 1]
	local title = " " .. wezterm.truncate_right(title_with_icon, max_width - 6) .. " "

	return {
		{ Attribute = { Intensity = "Bold" } },
		{ Text = id },
		{ Text = title },
		{ Text = pid },
		{ Foreground = { Color = "#b4befe" } },
		{ Background = { Color = "#181825" } },
		{ Text = " | " },
		{ Attribute = { Intensity = "Normal" } },
	}
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
		local date = wezterm.strftime("%m/%d/%Y")
		local time = wezterm.strftime("%H:%M")

		local divider = " " .. nf.pl_right_soft_divider .. " "

		-- Left status (left of the tab line)
		window:set_left_status(wezterm.format({
			{ Foreground = { Color = "#FFBBDD" } },
			{ Text = " do it for them  " .. nf.oct_heart .. "  " },
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
			{ Text = divider },
			{ Foreground = { Color = "#e0af68" } },
			{ Text = cmd_icon .. "  " .. cmd },
			"ResetAttributes",
			{ Text = divider },
			{ Foreground = { Color = charge_color } },
			{ Text = battery .. " " },
			{ Text = charge_percent .. " " },
			{ Text = state_suffix },
			"ResetAttributes",
			{ Text = divider },
			{ Text = nf.md_clock .. " " .. time .. " " .. date },
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
