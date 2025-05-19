return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			eslint = {
				mason = false,
			},
			html = {
				mason = false,
			},
			cssls = {
				mason = false,
			},
			jsonls = {
				mason = false,
			},
		},
	},
}
