---@type table<string, table<number | string, string>>
local charge_colors = {
	["Discharging"] = {
		[0] = "#FB5b5b",
		[0.1] = "#F3696F",
		[0.2] = "#ff8c9a",
		[0.3] = "#f3bb9a",
		[0.4] = "#FFDAB9",
		[0.5] = "#f8e7b0",
		[0.6] = "#F5FAB7",
		[0.7] = "#D1F0B9",
		[0.8] = "#C9F0AA",
		[0.9] = "#b4e49a",
		[1] = "#69de78",
	},
	["Charging"] = {
		[0] = "#69de78",
		[0.1] = "#7de28b",
		[0.2] = "#91e69e",
		[0.3] = "#a5eab1",
		[0.4] = "#b9eec4",
		[0.5] = "#cdefd7",
		[0.6] = "#dff3e8",
		[0.7] = "#d9f0f8",
		[0.8] = "#b9e8f7",
		[0.9] = "#a1def7",
		[1] = "#89d4f7",
	},
	["Full"] = {
		[1] = "#69de78",
	},
}

return { charge_colors = charge_colors }
