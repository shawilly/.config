---@diagnostic disable
local wezterm = require("wezterm")

local backdrops = require("custom.backdrop")

local format_tab_title = require("custom.tabs.format_tab_title")
local update_status = require("custom.status_bar.update_status")

wezterm.on("format-tab-title", format_tab_title)
wezterm.on("update-status", update_status)

return require("config")
