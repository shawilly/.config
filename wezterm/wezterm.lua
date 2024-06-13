---@diagnostic disable
local format_tab_title = require("custom.tabs.format_tab_title")
local update_status = require("custom.status_bar.update_status")
local wezterm = require("wezterm")
local backdrops = require("custom.gif_background.backdrops"):set_files():choices()
local config = require("config.config")

wezterm.on("format-tab-title", format_tab_title)
wezterm.on("update-status", update_status)

return config
