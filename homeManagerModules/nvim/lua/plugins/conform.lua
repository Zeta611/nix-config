return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			ocaml = { "ocamlformat" },
			typescript = function(bufnr)
				if require("conform").get_formatter_info("vtsls", bufnr).available then
					return { "vtsls", lsp_format = "never" }
				else
					return { "eslint" }
				end
			end,
		},
	},
}
