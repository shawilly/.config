local wezterm = require("wezterm")
local icons = require("assets.icons")

---@type table<string, string>
local dev_icons = icons.dev_icons

---@type table<string,table<string, string>>
local tab_numbers = icons.tab_numbers

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local editors = { "nvim", "vim", "vi" }
local clojure_tools = { "bb", "cmd-clj", "janet", "hy" }
local shells = { "lazygit", "bash", "fish" }

local function is_in_list(item, list)
	for _, v in ipairs(list) do
		if item == v then
			return true
		end
	end
	return false
end

local format_tab_title = function(tab, _tabs, _panes, _config, _hover, max_width)
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

	local id = tab_numbers.sub_idx[tab.tab_index + 1]
	local pid = tab_numbers.sup_idx[tab.active_pane.pane_index + 1]

	---@type string
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
end

return format_tab_title
