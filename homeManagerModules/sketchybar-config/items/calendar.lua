local colors = require("colors")

local cal = sbar.add("item", {
	icon = {
		padding_left = 12,
		padding_right = 8,
		font = {
			style = "Black",
			size = 12.0,
		},
	},
	label = {
		padding_right = 12,
		width = 45,
		align = "right",
	},
	position = "right",
	update_freq = 15,
})

local function update()
	local date = os.date("%a. %d %b.")
	local time = os.date("%H:%M")
	cal:set({ icon = date, label = time })
end

cal:subscribe("routine", update)
cal:subscribe("forced", update)
