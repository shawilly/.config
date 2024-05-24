require("utils.backdrops"):set_files():choices()

local wezterm = require("wezterm")
local act = wezterm.action
local nf = wezterm.nerdfonts

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
	["mongo"] = nf.dev_mongodb,
	["ssh"] = nf.md_ssh,
	["python"] = nf.dev_python,
	["admin"] = nf.oct_shield,
	["lambda"] = nf.md_lambda,
	["left_arrow"] = nf.md_arrow_left,
	["right_arrow"] = nf.md_arrow_right,
}

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
	size = 16.0,
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

wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, _hover, max_width)
	local process_name = tab.active_pane.foreground_process_name
	local pane_title = tab.active_pane.title
	local exec_name = basename(process_name):gsub("%.exe$", "")
	local title_with_icon = process_icons[exec_name] or nf.fa_terminal

	if exec_name == "nvim" then
		title_with_icon = title_with_icon .. " " .. pane_title:gsub("^(%S+)%s+(%d+/%d+) %- nvim", " %2 %1")
	elseif exec_name == "bb" or exec_name == "cmd-clj" or exec_name == "janet" or exec_name == "hy" then
		title_with_icon = title_with_icon .. " " .. exec_name:gsub("bb", "Babashka"):gsub("cmd%-clj", "Clojure")
	elseif exec_name == "bash" then
		title_with_icon = title_with_icon .. " " .. pane_title:gsub("~/", "")
	end

	if pane_title:match("^Administrator: ") then
		title_with_icon = title_with_icon .. "  " .. ADMIN_ICON
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
	local battery = nf.md_battery_heart
	local charge_color = "lightgreen"
	local charge_percent = ""
	local state_suffix = ""

	for _, b in ipairs(wezterm.battery_info()) do
		charge_percent = string.format("%.0f%%", b.state_of_charge * 100)

		if b.state_of_charge < 0.2 then
			battery = nf.md_battery_alert_variant_outline
			charge_color = "#F3B0A7"
		elseif b.state_of_charge < 0.4 then
			battery = nf.md_battery_40
			charge_color = "#FFDAB9"
		elseif b.state_of_charge < 0.6 then
			battery = nf.md_battery_60
			charge_color = "#F5F5B8"
		elseif b.state_of_charge < 0.8 then
			charge_color = "#B8E6C9"
			battery = nf.md_battery_80
		else
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
