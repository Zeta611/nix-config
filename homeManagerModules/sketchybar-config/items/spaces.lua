local colors = require("colors")

local aerospace = "/opt/homebrew/bin/aerospace"
local wss_cmd = aerospace .. " list-workspaces --monitor focused"
local nonempty_wss_cmd = aerospace .. " list-workspaces --monitor focused --empty no"
local focused_ws_cmd = aerospace .. " list-workspaces --focused"

local function string_to_table(s)
	local result = {}
	for line in s:gmatch("([^\n]+)") do
		table.insert(result, line)
	end
	return result
end

local function contains(tab, val)
	for _, v in ipairs(tab) do
		if v == val then
			return true
		end
	end
	return false
end

local function with_nonempty_wss(callback)
	sbar.exec(nonempty_wss_cmd, function(nonempty_wss_str)
		local nonempty_wss = string_to_table(nonempty_wss_str)
		callback(nonempty_wss)
	end)
end

local spaces = {}
local wss_items = {}

local function initialize_wss(wss, nonempty_wss, focused_ws)
	for i, ws in ipairs(wss) do
		local selected = ws == focused_ws
		local nonempty = contains(nonempty_wss, ws)

		local space = sbar.add("item", "space." .. ws, {
			position = "left",
			icon = {
				string = ws,
				padding_left = 2,
				padding_right = 2,
				highlight_color = colors.red,
				highlight = selected,
				drawing = nonempty or selected,
			},
			label = {
				drawing = nonempty or selected,
			},
			padding_left = 0,
			padding_right = 0,
			click_script = aerospace .. " workspace " .. ws,
		})
		wss_items[ws] = space
		spaces[i] = space.name
	end

	sbar.add("item", "space.prev", {
		padding_left = 6,
		padding_right = 6,
		icon = {
			string = "􀆉",
			font = {
				style = "Heavy",
			},
		},
		label = { drawing = false },
		associated_display = "active",
		click_script = aerospace .. " workspace prev",
	})
	spaces[#spaces + 1] = "space.prev"

	sbar.add("item", "space.next", {
		padding_left = -4,
		padding_right = 8,
		icon = {
			string = "􀆊",
			font = {
				style = "Heavy",
			},
		},
		label = { drawing = false },
		associated_display = "active",
		click_script = aerospace .. " workspace next",
	})
	spaces[#spaces + 1] = "space.next"

	sbar.add("bracket", spaces, {})

	sbar.exec("sketchybar --move space.prev before space.1")
end

-- Adding `with_nonempty_wss` to each item is expensive, so we'll add a sentinel
-- item solely for the purpose of subscribing to `aerospace_workspace_change`
-- and updating the workspace items inside the `with_nonempty_wss` callback.
local sentinel = sbar.add("item", {
	position = "left",
	padding_left = 0,
	padding_right = 0,
	width = 0,
})
sentinel:subscribe("aerospace_workspace_change", function(env)
	with_nonempty_wss(function(nonempty_wss)
		for ws, item in pairs(wss_items) do
			local selected = env.FOCUSED_WORKSPACE == ws
			local nonempty = contains(nonempty_wss, ws)
			item:set({
				icon = {
					highlight = selected,
					drawing = nonempty or selected,
				},
				label = {
					drawing = nonempty or selected,
				},
			})
		end
	end)
end)

sbar.exec(wss_cmd, function(wss_str)
	local wss = string_to_table(wss_str)
	sbar.exec(nonempty_wss_cmd, function(nonempty_wss_str)
		local nonempty_wss = string_to_table(nonempty_wss_str)
		sbar.exec(focused_ws_cmd, function(focused_ws_str)
			local focused_ws = string_to_table(focused_ws_str)[1]
			initialize_wss(wss, nonempty_wss, focused_ws)
			sbar.exec("sketchybar --move front_app after space.next")
		end)
	end)
end)
