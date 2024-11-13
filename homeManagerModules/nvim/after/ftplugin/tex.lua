vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.conceallevel = 0

vim.g.autoformat = false

local buffer = vim.api.nvim_get_current_buf()
vim.schedule(function()
	vim.keymap.set("n", "]]", "<plug>(vimtex-]])", { buffer = buffer })
	vim.keymap.set("n", "[[", "<plug>(vimtex-[[)", { buffer = buffer })
end)

vim.cmd([[ highlight Normal ctermbg=NONE ctermfg=16 guibg=NONE guifg=#000000 ]])
