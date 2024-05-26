local wezterm = require("wezterm")
local icons = require("assets.icons")

---@type table<string, string>
local dev_icons = icons.dev_icons

---@type table<string,table<string, string>>
local tab_numbers = icons.tab_numbers

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local format_tab_title = function(tab, _tabs, _panes, _config, _hover, max_width)
	---@type string
	local process_name = tab.active_pane.foreground_process_name
	---@type string
	local pane_title = tab.active_pane.title

	---@type string
	local exec_name = basename(process_name):gsub("%.exe$", "")
	local title_with_icon = dev_icons[exec_name] or dev_icons["default"]

	if exec_name == "nvim" then
		title_with_icon = title_with_icon .. " " .. pane_title:gsub("^(%S+)%s+(%d+/%d+) %- nvim", " %2 %1")
	elseif exec_name == "bb" or exec_name == "cmd-clj" or exec_name == "janet" or exec_name == "hy" then
		title_with_icon = title_with_icon .. " " .. exec_name:gsub("bb", "Babashka"):gsub("cmd%-clj", "Clojure")
	elseif exec_name == "bash" then
		title_with_icon = title_with_icon .. " " .. pane_title:gsub("~/", "")
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
