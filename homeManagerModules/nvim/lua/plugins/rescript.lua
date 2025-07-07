return {
	{ "rescript-lang/vim-rescript", ft = "rescript" },
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				rescriptls = {
					mason = false,
				},
			},
		},
	},
}
