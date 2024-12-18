local icons = require("icons")
local colors = require("colors")

local popup_toggle = "sketchybar --set $NAME popup.drawing=toggle"

local apple_logo = sbar.add("item", {
	click_script = popup_toggle,
	icon = {
		string = "λ",
		font = {
			style = "Black",
		},
		padding_left = 11,
		padding_right = 9,
	},
	label = {
		drawing = false,
	},
	popup = {
		height = 30,
	},
	-- background = {
	-- 	color = colors.black,
	-- },
})

local apple_prefs = sbar.add("item", {
	position = "popup." .. apple_logo.name,
	icon = icons.preferences,
	label = "Preferences",
})

apple_prefs:subscribe("mouse.clicked", function(_)
	sbar.exec("open -a 'System Preferences'")
	apple_logo:set({ popup = { drawing = false } })
end)
