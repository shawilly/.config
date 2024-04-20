local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

config.font = wezterm.font("Hurmit Nerd Font", { weight = "Bold" })
config.font_size = 18
config.automatically_reload_config = true
config.keys = {
	-- copy and paste from the standard register
	{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
	-- tabs
	{ key = "t", mods = "SUPER", action = act.SpawnTab("DefaultDomain") },
	-- tabs: navigation
	{ key = "[", mods = "SUPER", action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "SUPER", action = act.ActivateTabRelative(1) },
	{ key = "[", mods = "SUPER|CTRL", action = act.MoveTabRelative(-1) },
	{ key = "]", mods = "SUPER|CTRL", action = act.MoveTabRelative(1) },
}

return config
