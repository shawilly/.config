---@diagnostic disable
local wezterm = require("wezterm")
local colors = require("custom.status_bar.colors")
local icons = require("assets.icons")
---@diagnostic enable

---@type table<string, string>
local palette = require("theme.ponokai.palette")

---@type table<string, string>
local charge_colors = colors.charge_colors
---@type table<string, string>
local dev_icons = icons.dev_icons
---@type table<string, string>
local battery_icons = icons.battery
---@type table<string, string>
local dividers = icons.dividers
---@type string

local basename = function(s)
	---@type string
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local update_status = function(window, pane)
	---@type string
	local battery = battery_icons[1]

	---@type string
	local charge_color = charge_colors[1]

	---@type table<string, table>
	local battery_info = wezterm.battery_info()

	---@type fun(): (number, table<string, string>)
	for _, b in pairs(battery_info) do
		---@type string
		local state = b.state

		---@type string
		local state_of_charge = b.state_of_charge
		local charge_percent = string.format("%.0f%%", state_of_charge * 100)

		---@type number
		local charge_key = math.floor(state_of_charge * 10) / 10

		---@type string
		battery = battery_icons[state][charge_key]
		---@type string
		charge_color = charge_colors[state][charge_key]

		local state_suffix = ""
		if state == "Charging" and b.time_to_full then
			---@type string
			state_suffix = icons.dev_icons[state] .. " " .. math.ceil(b.time_to_full / 60) .. "m"
		elseif state == "Discharging" and b.time_to_empty then
			state_suffix = math.ceil(b.time_to_empty / 60) .. "m"
		end

		---@type string
		local date = wezterm.strftime("%h %d "):lower()
		---@type string
		local time = wezterm.strftime("%H:%M")

		-- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l). Not a big deal, but check in case
		---@type table<string, string>
		local cwd = pane:get_current_working_dir()

		local current_working_directory = basename(cwd.path) or ""
		local current_command = basename(pane:get_foreground_process_name()) or ""

		---@type string
		local cmd_icon = dev_icons[current_command] or dev_icons["default"]

		---@type string
		local directory = dev_icons["folder"] .. " " .. current_working_directory
		local process = cmd_icon .. "  " .. current_command

		---@type string
		local date_time = icons.dev_icons["clock"] .. " " .. time .. " " .. date

		window:set_right_status(wezterm.format({
			{ Foreground = { Color = palette["bg1"] } },
			{ Text = dividers["left_circle"] },
			{ Background = { Color = palette["bg1"] } },
			{ Foreground = { Color = palette["purple_100"] } },
			{ Text = " " .. directory .. " " },
			{ Foreground = { Color = palette["bg3"] } },
			{ Text = dividers["hard_right"] },
			{ Background = { Color = palette["bg3"] } },
			{ Foreground = { Color = palette["purple_300"] } },
			{ Text = " " .. process .. " " },
			{ Foreground = { Color = palette["bg4"] } },
			{ Text = dividers["hard_right"] },
			{ Background = { Color = palette["bg4"] } },
			{ Foreground = { Color = charge_color } },
			{ Text = " " .. battery .. " " },
			{ Text = charge_percent .. " " },
			{ Text = state_suffix .. " " },
			{ Foreground = { Color = charge_color } },
			{ Text = dividers["hard_right"] },
			{ Background = { Color = charge_color } },
			{ Foreground = { Color = palette["bg0"] } },
			{ Text = date_time },
			{ Background = { Color = palette["bg0"] } },
			{ Foreground = { Color = charge_color } },
			{ Text = dividers["right_circle"] },
			{ Foreground = { Color = charge_color } },
		}))
	end
end

return update_status
