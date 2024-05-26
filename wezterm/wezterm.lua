local format_tab_title = require("custom.tabs.format_tab_title")
local update_status = require("custom.status_bar.update_status")
local user_var_changed = require("custom.window.user_var_changed")

---@type any
local wezterm = require("wezterm")

-- background
local backdrops = require("custom.gif_background.backdrops")
backdrops:set_files():choices()

local config = require("config.config")

-- custom functions
wezterm.on("format-tab-title", format_tab_title)
wezterm.on("update-status", update_status)
wezterm.on("user-var-changed", user_var_changed)

return config
