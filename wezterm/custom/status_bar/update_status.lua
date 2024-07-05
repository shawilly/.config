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

		---@type string
		local time = wezterm.strftime("%H:%M")

		-- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l). Not a big deal, but check in case
		---@type table<string, string>
		local cwd = pane:get_current_working_dir()

		local current_working_directory = basename(cwd.path) or ""

		---@type string
		local directory = dev_icons["folder"] .. " " .. current_working_directory

		---@type string
		local date_time = icons.dev_icons["clock"] .. " " .. time .. " "

		window:set_right_status(wezterm.format({
			{ Foreground = { Color = palette["bg6"] } },
			{ Text = dividers["left_circle"] },
			{ Background = { Color = palette["bg6"] } },
			{ Foreground = { Color = palette["fg"] } },
			{ Text = " " .. directory .. " " },
			{ Foreground = { Color = palette["bg5"] } },
			{ Text = dividers["hard_right"] },
			{ Background = { Color = palette["bg5"] } },
			{ Foreground = { Color = charge_color } },
			{ Text = " " .. battery .. " " },
			{ Text = charge_percent .. " " },
			{ Foreground = { Color = charge_color } },
			{ Text = dividers["hard_right"] },
			{ Background = { Color = charge_color } },
			{ Foreground = { Color = palette["bg0"] } },
			{ Text = date_time },
		}))
	end
end

return update_status
