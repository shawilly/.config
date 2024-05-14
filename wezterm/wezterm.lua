require("utils.backdrops"):set_files():choices()

local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

config.native_macos_fullscreen_mode = true

-- background
local backdrops = require("utils.backdrops")
config.window_background_opacity = 0.3
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
config.color_scheme_dirs = { "../../wezterm-dracula/dracula.toml" }
config.color_scheme = "catppuccino"

-- font
config.font = wezterm.font({
	family = "RobotoMono Nerd Font",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.bold_brightens_ansi_colors = true

-- tab bar
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.status_update_interval = 1000

wezterm.on("update-status", function(window, pane)
	-- Time
	local time = wezterm.strftime("%H:%M")

	-- Left status (left of the tab line)
	window:set_left_status(wezterm.format({
		{ Text = " do it for them <3 " },
		{ Text = " |" },
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
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		{ Text = " | " },
		{ Foreground = { Color = "#e0af68" } },
		{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
		"ResetAttributes",
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_clock .. "  " .. time },
		{ Text = "  " },
	}))
end)

wezterm.on("update-right-status", function(window, pane)
	-- "Wed Mar 3 08:14"
	local date = wezterm.strftime("%a %b %-d %H:%M ")
	local battery_status = ""
	local cwd = ""
	local hostname = ""

	for _, b in ipairs(wezterm.battery_info()) do
		local icon = "🌕"

		-- Change icon color based on charge level
		if b.state_of_charge < 0.2 then
			icon = "🌑"
		elseif b.state_of_charge < 0.4 then
			icon = "🌘"
		elseif b.state_of_charge < 0.6 then
			icon = "🌗"
		elseif b.state_of_charge < 0.8 then
			icon = "🌖"
		end

		-- Display charging or discharging state
		local state_suffix = ""
		if b.state == "Charging" then
			state_suffix = " ⚡" -- Lightning bolt icon for charging
			if b.time_to_full then
				state_suffix = state_suffix .. " (" .. math.ceil(b.time_to_full / 60) .. " min to full)"
			end
		elseif b.state == "Discharging" then
			if b.time_to_empty then
				state_suffix = " (" .. math.ceil(b.time_to_empty / 60) .. " min to empty)"
			end
		end

		local charge_percent = string.format("%.0f%%", b.state_of_charge * 100)

		battery_status = battery_status .. icon .. " " .. charge_percent .. state_suffix .. "  "
	end

	local cwd_uri = pane:get_current_working_dir()
	if cwd_uri then
		if type(cwd_uri) == "userdata" then
			cwd = cwd_uri.file_path
			hostname = cwd_uri.host or wezterm.hostname()
		else
			cwd_uri = cwd_uri:sub(8)
			local slash = cwd_uri:find("/")
			if slash then
				hostname = cwd_uri:sub(1, slash - 1)
				cwd = cwd_uri:sub(slash):gsub("%%(%x%x)", function(hex)
					return string.char(tonumber(hex, 16))
				end)
			end
		end

		local dot = hostname:find("[.]")
		if dot then
			hostname = hostname:sub(1, dot - 1)
		end
		if hostname == "" then
			hostname = wezterm.hostname()
		end
	end

	-- Set the right status with detailed battery info and current time
	window:set_right_status(wezterm.format({
		{ Text = cwd .. "    " .. battery_status .. " " .. date },
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
}
config.keys = keys

return config
