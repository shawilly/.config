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
config.window_background_gradient = {
	orientation = "Vertical",
	colors = {
		"#2c2e34",
		"#2c2e34",
		"#17181c",
	},
	interpolation = "Linear",
	blend = "Rgb",
}

config.font = wezterm.font("Hurmit Nerd Font", { weight = "Bold" })
config.font_size = 18
config.bold_brightens_ansi_colors = true

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
	local battery_status = ""
	local cwd = ""
	local hostname = ""

	for _, b in ipairs(wezterm.battery_info()) do
		local icon = "🔋"
		local charge_percent = string.format("%.0f%%", b.state_of_charge * 100)

		-- Change icon color based on charge level
		if b.state_of_charge < 0.2 then
			icon = "🌑"
		elseif b.state_of_charge < 0.4 then
			icon = "🌘"
		elseif b.state_of_charge < 0.6 then
			icon = "🌗"
		elseif b.state_of_charge < 0.8 then
			icon = "🌖"
		else
			icon = "🌕"
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

return config
