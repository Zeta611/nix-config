return {
	-- https://github.com/zbirenbaum/copilot.lua
	"zbirenbaum/copilot.lua",
	opts = {
		suggestion = {
			auto_trigger = true,
			keymap = {
				accept = "<C-M-l>",
				accept_word = "<C-l>",
			},
		},
		filetypes = {
			["."] = true,
		},
	},
}
