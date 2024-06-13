---@diagnostic disable
local wezterm = require("wezterm")
local icons = require("assets.icons")
---@diagnostic enable

---@type table<string, string>
local palette = require("theme.ponokai.palette")

---@type table<string, string>
local dev_icons = icons.dev_icons

---@type table<string,table<string, string>>
local tab_numbers = icons.tab_numbers

---@type table<string, string>
local dividers = icons.dividers

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local color_names = { "red", "orange", "yellow", "green", "blue", "purple" }

local function next_color(index, active)
	local color_name = color_names[index] .. (active and "_900" or "_300")
	return palette[color_name]
end

local editors = { "nvim", "vim", "vi" }
local clojure_tools = { "bb", "cmd-clj", "janet", "hy" }
local shells = { "lazygit", "bash", "fish" }

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

local format_tab_title = function(tab, tabs, _panes, _config, _hover, max_width)
	---@type string
	local process_name = tab.active_pane.foreground_process_name
	---@type string
	local pane_title = tab.active_pane.title

	---@type string
	local exec_name = basename(process_name):gsub("%.exe$", "")
	local title_with_icon = dev_icons[exec_name] or dev_icons["default"]

	if is_in_list(exec_name, editors) then
		title_with_icon = title_with_icon .. " " .. pane_title:gsub("^(%S+)%s+(%d+/%d+) %- nvim", " %2 %1")
	elseif is_in_list(exec_name, clojure_tools) then
		title_with_icon = title_with_icon .. " " .. exec_name:gsub("bb", "Babashka"):gsub("cmd%-clj", "Clojure")
	elseif is_in_list(exec_name, shells) then
		title_with_icon = title_with_icon .. " " .. pane_title:gsub("~/", "")
	else
		title_with_icon = title_with_icon .. " " .. pane_title
	end

	local id = tab_numbers.number[tab.tab_index + 1]
	local background = next_color(tab.tab_index + 1, tab.is_active)
	local last_background = palette["bg0"]
	local intensity = "Half"

	if tab.tab_index == 0 then
		last_background = palette["bg4"]
	end
	if tab.is_active then
		intensity = "Bold"
	end

	---@type string
	local title = " " .. wezterm.truncate_right(title_with_icon, max_width - 6) .. " "

	local formatted_tab = {
		{ Background = { Color = background } },
		{ Foreground = { Color = last_background } },
		{ Text = dividers["hard_left"] },
		{ Background = { Color = background } },
		{ Foreground = { Color = palette["bg0"] } },
		{ Attribute = { Intensity = intensity } },
		{ Text = " " .. id },
		{ Text = title },
		{ Foreground = { Color = background } },
		{ Background = { Color = palette["bg0"] } },
		{ Text = dividers["hard_left"] },
	}

	return formatted_tab
end

return format_tab_title
