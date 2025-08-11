return {
	"olimorris/codecompanion.nvim",
	keys = {
		{ "<C-a>", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanion: Actions" },
		{
			"<Leader>a",
			mode = { "n", "v" },
			"<cmd>CodeCompanionChat Toggle<cr>",
			desc = "CodeCompanion: Toggle Chat",
		},
		{ "ga", mode = { "v" }, "<cmd>CodeCompanionChat Add<cr>", desc = "CodeCompanion: Add Selection To Chat" },
	},
	opts = {
		-- Keymaps for CodeCompanion using LazyVim native options
		adapters = {
			openai = function()
				return require("codecompanion.adapters").extend("openai", {
					schema = {
						model = {
							choices = {
								["gpt-5"] = { opts = { has_vision = true, can_reason = true } },
							},
						},
					},
				})
			end,
		},
		strategies = {
			chat = {
				adapter = "openai",
			},
			inline = {
				adapter = "openai",
			},
			cmd = {
				adapter = "openai",
			},
		},
		extensions = {
			history = {
				enabled = true,
			},
		},
	},
	dependencies = {
		-- Expand 'cc' into 'CodeCompanion' in the command line
		config = function(_, opts)
			vim.cmd([[cab cc CodeCompanion]])
		end,
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"ravitemer/codecompanion-history.nvim",
	},
}
