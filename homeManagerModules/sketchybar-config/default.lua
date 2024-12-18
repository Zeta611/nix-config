local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
sbar.default({
	updates = "when_shown",
	icon = {
		font = {
			family = settings.font,
			style = "Bold",
			size = 14.0,
		},
		color = colors.item.fg,
		padding_left = settings.paddings,
		padding_right = settings.paddings,
	},
	label = {
		font = {
			family = settings.font,
			style = "Semibold",
			size = 13.0,
		},
		color = colors.item.fg,
		padding_left = settings.paddings,
		padding_right = settings.paddings,
	},
	background = {
		height = 30,
		corner_radius = 15,
		color = colors.item.bg,
	},
	popup = {
		background = {
			border_width = 1,
			corner_radius = 15,
			border_color = colors.popup.border,
			color = colors.popup.bg,
			shadow = { drawing = false },
		},
	},
	padding_left = 5,
	padding_right = 5,
})
