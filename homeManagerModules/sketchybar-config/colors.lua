local ansi = {
	black = 0xffa1a6c5,
	red = 0xffff4774,
	green = 0xff5c8524,
	yellow = 0xffa27629,
	blue = 0xff358aff,
	magenta = 0xffa463ff,
	cyan = 0xff007ea8,
	white = 0xff3760bf,
}
local apple = {
	red = 0xfffd4646,
	yellow = 0xfffeb024,
	green = 0xff61c554,
}

return {
	black = ansi.black,
	white = ansi.white,
	red = ansi.red,
	green = ansi.green,
	yellow = ansi.yellow,
	blue = ansi.blue,
	magenta = ansi.magenta,
	cyan = ansi.cyan,
	transparent = 0x00000000,
	item = {
		fg = 0xffffffff,
		bg = 0xff000000,
	},
	popup = {
		bg = 0xff000000,
		border = 0xffb15c00,
	},
	ansi = ansi,
	apple = apple,
}
