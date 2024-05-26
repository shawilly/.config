local wezterm = require("wezterm")
local colors = require("custom.status_bar.colors")
local icons = require("assets.icons")

local dev_icons = icons.dev_icons
local battery_icons = icons.battery
local soft_divider = " " .. icons.dividers["soft_right"] .. " "
local hard_divider = " " .. icons.dividers["hard_right"] .. " "

local heart = icons.dividers["heart"]

local basename = function(s)
	---@type string
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local update_status = function(window, pane)
	local battery = battery_icons["Full"]

	---@type string
	local charge_color = colors["Full"]
	local charge_percent = ""

	---@type table<string, table>
	local battery_info = wezterm.battery_info()

	for _, b in ipairs(battery_info) do
		---@type string
		local state = b.state

		---@type string
		local state_of_charge = b.state_of_charge

		---@type number
		local charge_key = math.ceil(state_of_charge * 10) / 10
		charge_percent = string.format("%.0f%%", state_of_charge * 100)

		---@type string
		battery = battery_icons[state][charge_key]

		---@type string
		charge_color = colors[charge_key]

		local state_suffix = ""

		if state == "Charging" and b.time_to_full then
			state_suffix = icons.dev_icons[state] .. " " .. math.ceil(b.time_to_full / 60) .. "m"
		elseif state == "Discharging" and b.time_to_empty then
			state_suffix = math.ceil(b.time_to_empty / 60) .. "m"
		end
		--
		---@type string
		local date = wezterm.strftime("%m/%d/%Y")
		---@type string
		local time = wezterm.strftime("%H:%M")

		-- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l). Not a big deal, but check in case
		---@type table<string, string>
		local cwd = pane:get_current_working_dir()

		local current_working_directory = basename(cwd.path) or ""
		-- Current command
		local current_command = basename(pane:get_foreground_process_name()) or ""

		---@type string
		local cmd_icon = dev_icons[current_command] or dev_icons["default"]

		local directory = dev_icons["folder"] .. " " .. current_working_directory
		local process = cmd_icon .. "  " .. current_command
		local date_time = icons.dev_icons["clock"] .. " " .. time .. " " .. date

		window:set_left_status(wezterm.format({
			{ Foreground = { Color = charge_color } },
			{ Text = " do it for them  " .. heart .. "  " },
		}))

		window:set_right_status(wezterm.format({
			{ Foreground = { Color = "#AAAAFF" } },
			{ Text = directory },
			"ResetAttributes",
			{ Text = soft_divider },
			{ Foreground = { Color = "#e0af68" } },
			{ Text = process },
			"ResetAttributes",
			{ Text = soft_divider },
			{ Foreground = { Color = charge_color } },
			{ Text = battery .. " " },
			{ Text = charge_percent .. " " },
			{ Text = state_suffix },
			{ Background = { Color = "grey" } },
			{ Text = hard_divider },
			"ResetAttributes",
			{ Background = { Color = "grey" } },
			{ Text = date_time },
			{ Text = "  " },
		}))
	end
end

return update_status
