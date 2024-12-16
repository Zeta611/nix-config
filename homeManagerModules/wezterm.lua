local wezterm = require("wezterm")
local act = wezterm.action

local function get_home_dir()
	return os.getenv("HOME")
end

return {
	default_prog = { get_home_dir() .. "/.nix-profile/bin/fish", "-l" },
	font_size = 15.0,
	color_scheme = "tokyonight_day",
	window_decorations = "INTEGRATED_BUTTONS|RESIZE",
	scrollback_lines = 1048576,
	enable_scroll_bar = true,
	keys = {
		{ key = "1", mods = "CTRL", action = act.ActivateTab(0) },
		{ key = "2", mods = "CTRL", action = act.ActivateTab(1) },
		{ key = "3", mods = "CTRL", action = act.ActivateTab(2) },
		{ key = "4", mods = "CTRL", action = act.ActivateTab(3) },
		{ key = "5", mods = "CTRL", action = act.ActivateTab(4) },
		{ key = "6", mods = "CTRL", action = act.ActivateTab(5) },
		{ key = "7", mods = "CTRL", action = act.ActivateTab(6) },
		{ key = "8", mods = "CTRL", action = act.ActivateTab(7) },
		{ key = "9", mods = "CTRL", action = act.ActivateTab(8) },
		{ key = "0", mods = "CTRL", action = act.ActivateTab(9) },
		{ key = "|", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "_", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "h", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Left") },
		{ key = "j", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Up") },
		{ key = "l", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Right") },
	},
}
