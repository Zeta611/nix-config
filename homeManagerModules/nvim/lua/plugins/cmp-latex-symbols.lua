return {
	"hrsh7th/nvim-cmp",
	dependencies = { "kdheepak/cmp-latex-symbols" },
	opts = function(_, opts)
		local cmp = require("cmp")
		opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
			{
				name = "latex_symbols",
				option = {
					strategy = 1, -- mixed
				},
			},
		}))
	end,
}
