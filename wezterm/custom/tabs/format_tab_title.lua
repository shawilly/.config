---@diagnostic disable
local wezterm = require("wezterm")
local icons = require("assets.icons")
local secrets = require("config.secrets")
---@diagnostic enable

---@type string
local ecck_ssh_url = secrets["ECCK_SSH_URL"]

---@type table<string, string>
local palette = require("theme.ponokai.palette")

---@type table<string, string>
local dev_icons = icons.dev_icons

---@type table<string,table<string, string>>
local tab_numbers = icons.tab_numbers

---@type table<string, string>
local dividers = icons.dividers

--- Any number to roman numeral converter
---@param num number
---@return string
local function to_roman(num)
	local roman_numerals = {
		{ 1000, "M" },
		{ 900, "CM" },
		{ 500, "D" },
		{ 400, "CD" },
		{ 100, "C" },
		{ 90, "XC" },
		{ 50, "L" },
		{ 40, "XL" },
		{ 10, "X" },
		{ 9, "IX" },
		{ 5, "V" },
		{ 4, "IV" },
		{ 1, "I" },
	}

	local result = ""

	for _, pair in ipairs(roman_numerals) do
		local value, numeral = pair[1], pair[2]
		while num >= value do
			result = result .. numeral
			num = num - value
		end
	end

	return result
end

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local color_names = { "red", "orange", "yellow", "green", "blue", "purple" }

local function get_color(index, active)
	---@type number
	local color_index = ((index - 1) % #color_names) + 1
	local color_name = color_names[color_index] .. (active and "_900" or "_300")

	return palette[color_name]
end

local editors = { "nvim", "vim", "vi" }
local shells = { "ssh", "zsh", "lazygit", "bash", "fish" }

--- Check if an item is in a list
---@param item any
---@param list any
---@return boolean
local function is_in_list(item, list)
	---@diagnostic disable-next-line
	for _, v in ipairs(list) do
		if item == v then
			return true
		end
	end
	return false
end

--- Format tab title with icons, colors, and dividers
---@return table
local format_tab_title = function(tab, tabs, _panes, _config, _hover, max_width)
	---@type string
	local process_name = tab.active_pane.foreground_process_name
	---@type string
	local exec_name = basename(process_name):gsub("%.exe$", "")
	---@type string
	local pane_title = tab.active_pane.title:gsub(exec_name, "")

	local title_with_icon = dev_icons[exec_name] or dev_icons["default"]

	if string.find(pane_title, "No Name") and exec_name == "nvim" then
		title_with_icon = title_with_icon
	elseif string.find(pane_title, "ubuntu@ip") then
		title_with_icon = title_with_icon .. " ecck"
	elseif is_in_list(exec_name, editors) then
		title_with_icon = title_with_icon .. " " .. pane_title:gsub("^(%S+)%s+(%d+/%d+) %- nvim", " %2 %1")
	elseif is_in_list(exec_name, shells) then
		---@type string
		title_with_icon = title_with_icon .. " " .. pane_title:gsub(exec_name, "")
		title_with_icon = title_with_icon:gsub("~/", "")
		title_with_icon = title_with_icon:gsub(".config", "cnf")
	else
		title_with_icon = title_with_icon .. " " .. pane_title
	end

	local tab_main_color = get_color(tab.tab_index + 1, tab.is_active)
	local start_of_tab_icon_color = tab_main_color
	local start_of_tab_bg = tab_main_color

	if tab.tab_index == 0 then
		start_of_tab_bg = palette["bg0"]
	else
		start_of_tab_icon_color = palette["bg0"]
	end

	local number_icon = tab.tab_index < 10 and tab_numbers.number[tab.tab_index + 1] or to_roman(tab.tab_index + 1)
	local number_icon_color = get_color(tab.tab_index + 1, tab.is_active == false)

	local font_color = tab.is_active and palette["bg0"] or palette["bg4"]
	local font_weight = "Half"

	if tab.is_active then
		font_weight = "Bold"
	end

	local is_last_tab = tab.tab_index == #tabs - 1
	local is_first_tab = tab.tab_index == 0

	local start_of_tab_icon = is_first_tab and dividers["left_circle"] or dividers["hard_left"]
	local end_of_tab_icon = is_last_tab and dividers["right_circle"] or dividers["hard_left"]

	---@type string
	local title = " " .. wezterm.truncate_right(title_with_icon, max_width - 6) .. " "

	local ponokai_tab = {
		{ Background = { Color = start_of_tab_bg } },
		{ Foreground = { Color = start_of_tab_icon_color } },
		{ Text = start_of_tab_icon },
		{ Background = { Color = tab_main_color } },
		{ Attribute = { Intensity = font_weight } },
		{ Foreground = { Color = number_icon_color } },
		{ Text = " " .. number_icon },
		{ Foreground = { Color = font_color } },
		{ Text = title },
		{ Foreground = { Color = tab_main_color } },
		{ Background = { Color = palette["bg0"] } },
		{ Text = end_of_tab_icon },
	}

	return ponokai_tab
end

return format_tab_title
