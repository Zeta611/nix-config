local wezterm = require("wezterm")
local act = wezterm.action
local hostname = wezterm.hostname()

local font_size
local window_decorations
if hostname == "jay-nixos" then
	font_size = 12.0
	window_decorations = "NONE"
elseif hostname == "jay-macbook" then
	font_size = 15.0
	window_decorations = "NONE"
else
	font_size = 15.0
	window_decorations = "INTEGRATED_BUTTONS|RESIZE"
end

return {
	default_prog = { wezterm.home_dir .. "/.nix-profile/bin/fish", "-l" },
	font_size = font_size,
	window_decorations = window_decorations,
	use_fancy_tab_bar = false,
	color_scheme = "tokyonight_day",
	hide_tab_bar_if_only_one_tab = true,
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
