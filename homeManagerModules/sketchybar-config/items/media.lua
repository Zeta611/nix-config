local icons = require("icons")
local colors = require("colors")

local whitelist = { ["Spotify"] = true, ["Music"] = true }

local media = sbar.add("item", "media", {
	drawing = false,
	icon = {
		string = icons.music,
		color = 0xffffffff,
		padding_left = 10,
		padding_right = 8,
	},
	position = "q",
	updates = true,
	label = {
		padding_right = 12,
		color = 0xffffffff,
		max_chars = 30,
	},
	background = {
		color = colors.red,
	},
	scroll_texts = true,
	scroll_duration = 250,
})

media:subscribe("media_change", function(env)
	if whitelist[env.INFO.app] then
		media:set({
			drawing = env.INFO.state == "playing",
			label = env.INFO.artist .. ": " .. env.INFO.title,
		})
	end
end)
