return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		local hostname = vim.fn.hostname()
		if hostname == "jay-macbook-pro" then
			vim.g.vimtex_view_method = "skim"
		elseif hostname == "jay-nixos" then
			vim.g.vimtex_view_general_viewer = "zathura"
			vim.g.vimtex_view_general_options =
				[[ -x "nvim --headless -c \"VimtexInverseSearch %{line}:%{column} '%{input}'\"" --synctex-forward @line:@col:'@tex' '@pdf' ]]
		end

		vim.g.vimtex_quickfix_ignore_filters = { "LaTeX Font Warning: Size substitutions" }
		vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1
	end,
}
