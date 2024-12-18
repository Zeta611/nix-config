local colors = require("colors")

local front_app = sbar.add("item", "front_app", {
	icon = {
		drawing = false,
	},
	label = {
		font = {
			style = "Black",
			size = 12.0,
		},
		padding_left = 12,
		padding_right = 12,
	},
})

front_app:subscribe("front_app_switched", function(env)
	front_app:set({
		label = {
			string = env.INFO,
		},
	})

	-- Or equivalently:
	-- sbar.set(env.NAME, {
	--   label = {
	--     string = env.INFO
	--   }
	-- })
end)
