local colors = require("colors")

local function concat(...)
	local result = {}
	for i = 1, select("#", ...) do
		local arg = select(i, ...)
		for _, v in ipairs(arg) do
			table.insert(result, v)
		end
	end
	return result
end

require("items.apple")
require("items.spaces")
require("items.front_app")
require("items.calendar")
-- require("items.uname")
local volume = require("items.volume")
local battery = require("items.battery")
require("items.media")

sbar.add("bracket", concat(volume, battery), {})
