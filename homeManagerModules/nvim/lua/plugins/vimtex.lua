return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		local hostname = vim.fn.hostname()
		if hostname == "jay-macbook-pro" then
			vim.g.vimtex_view_method = "skim"
		elseif hostname == "jay-nixos" then
			vim.g.vimtex_view_method = "zathura"
		end
	end,
}
