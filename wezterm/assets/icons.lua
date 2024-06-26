---@diagnostic disable-next-line
local wezterm = require("wezterm")

---@type table<string, string>
local nf = wezterm.nerdfonts

---@type table<string, string>
local dividers = {
	["hard_right"] = nf.pl_right_hard_divider,
	["hard_left"] = nf.pl_left_hard_divider,
	["hard_right_inverse"] = nf.pl_right_hard_divider_inverse,
	["hard_left_inverse"] = nf.pl_left_hard_divider_inverse,
	["heart"] = nf.oct_heart,
	["soft_right"] = nf.pl_right_soft_divider,
	["soft_left"] = nf.pl_left_soft_divider,
	["left_circle"] = "",
	["right_circle"] = "",
}

---Keep sorted alphabetically by name
---@type table<string, string>
local dev_icons = {
	["admin"] = nf.oct_shield,
	["bash"] = nf.cod_terminal_bash,
	["btm"] = nf.mdi_chart_donut_variant,
	["cargo"] = nf.dev_rust,
	["Charging"] = nf.fa_plug,
	["clock"] = nf.md_clock_outline,
	["commit"] = nf.md_source_commit,
	["curl"] = nf.mdi_flattr,
	["default"] = nf.fa_terminal,
	["docker"] = nf.linux_docker,
	["docker-compose"] = nf.linux_docker,
	["dotnet"] = nf.md_language_csharp,
	["fish"] = nf.md_fish,
	["folder"] = nf.md_folder,
	["gh"] = nf.dev_github_badge,
	["git"] = nf.dev_git,
	["go"] = nf.seti_go,
	["htop"] = nf.mdi_chart_donut_variant,
	["java"] = nf.dev_java,
	["kubectl"] = nf.linux_docker,
	["kuberlr"] = nf.linux_docker,
	["lambda"] = nf.md_lambda,
	["lazydocker"] = nf.linux_docker,
	["left_arrow"] = nf.md_arrow_left,
	["lua"] = nf.seti_lua,
	["make"] = nf.seti_makefile,
	["mongo"] = nf.dev_mongodb,
	["node"] = nf.dev_nodejs_small,
	["nvim"] = nf.custom_vim,
	["psql"] = nf.dev_postgresql,
	["pwsh"] = nf.seti_powershell,
	["python"] = nf.dev_python,
	["right_arrow"] = nf.md_arrow_right,
	["ruby"] = nf.cod_ruby,
	["ssh"] = nf.md_ssh,
	["stern"] = nf.linux_docker,
	["sudo"] = nf.fa_hashtag,
	["vi"] = nf.dev_vim,
	["vim"] = nf.dev_vim,
	["wget"] = nf.mdi_arrow_down_box,
	["zsh"] = nf.dev_terminal,
	["lazygit"] = nf.dev_git,
}

local tab_numbers = {
	number = {
		[1] = nf.md_numeric_1_circle,
		[2] = nf.md_numeric_2_circle,
		[3] = nf.md_numeric_3_circle,
		[4] = nf.md_numeric_4_circle,
		[5] = nf.md_numeric_5_circle,
		[6] = nf.md_numeric_6_circle,
		[7] = nf.md_numeric_7_circle,
		[8] = nf.md_numeric_8_circle,
		[9] = nf.md_numeric_9_circle,
		[10] = nf.md_numeric_10_circle,
	},
}

---@type table<string, string | table<number, string>>
local battery = {
	["Full"] = { [1] = nf.md_battery_heart },
	["Charging"] = {
		[0] = nf.md_battery_charging_outline,
		[0.1] = nf.md_battery_charging_10,
		[0.2] = nf.md_battery_charging_20,
		[0.3] = nf.md_battery_charging_30,
		[0.4] = nf.md_battery_charging_40,
		[0.5] = nf.md_battery_charging_50,
		[0.6] = nf.md_battery_charging_60,
		[0.7] = nf.md_battery_charging_70,
		[0.8] = nf.md_battery_charging_80,
		[0.9] = nf.md_battery_charging_90,
		[1] = nf.md_battery,
	},
	["Discharging"] = {
		[0] = nf.md_battery_alert_variant_outline,
		[0.1] = nf.md_battery_10,
		[0.2] = nf.md_battery_20,
		[0.3] = nf.md_battery_30,
		[0.4] = nf.md_battery_40,
		[0.5] = nf.md_battery_50,
		[0.6] = nf.md_battery_60,
		[0.7] = nf.md_battery_70,
		[0.8] = nf.md_battery_80,
		[0.9] = nf.md_battery_90,
		[1] = nf.md_battery,
	},
}

return {
	battery = battery,
	dev_icons = dev_icons,
	dividers = dividers,
	tab_numbers = tab_numbers,
}
