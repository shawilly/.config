local format_tab_title = require("custom.tabs.format_tab_title")
local update_status = require("custom.status_bar.update_status")

---@type any
local wezterm = require("wezterm")

-- background
local backdrops = require("custom.gif_background.backdrops")
backdrops:set_files():choices()

local config = require("config.config")

-- custom functions
wezterm.on("format-tab-title", format_tab_title)
wezterm.on("update-status", update_status)

return config
