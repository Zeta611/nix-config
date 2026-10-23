-- Catppuccin
vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
})
vim.cmd.colorscheme("catppuccin-latte")

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Let cmux's file explorer open files in the first running Neovim instance.
if vim.env.CMUX_WORKSPACE_ID then
  vim.fn.mkdir(vim.fn.stdpath("cache"), "p")
  pcall(vim.fn.serverstart, vim.fn.stdpath("cache") .. "/cmux.sock")
end

vim.o.number = true
vim.o.relativenumber = true
vim.o.expandtab = true
vim.o.tabstop = 8
vim.o.shiftwidth = 8
vim.o.termguicolors = true
vim.o.smartindent = true

for _, dir in ipairs({ "h", "j", "k", "l" }) do
  vim.keymap.set("n", "<C-" .. dir .. ">", "<C-w>" .. dir)
end

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", { desc = "Check LSP health" })

for _, key in ipairs({ "<C-n>", "<C-p>" }) do
  vim.keymap.set("i", key, function()
    -- if already open, use the key; otherwise, open omnicomplete suggestions
    return vim.fn.pumvisible() == 1 and key or "<C-x><C-o>"
  end, { expr = true, desc = "Omni completion" })
end

vim.keymap.set("n", "<leader>nd", function()
  vim.api.nvim_put({ os.date("%Y-%m-%d") }, "c", true, true)
end, { desc = "Insert today's date" })

vim.diagnostic.config({
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
})
-- show error
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
-- show quickfix
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    vim.lsp.buf.format({
      bufnr = args.buf,
      async = false,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  desc = "Disable automatic indentation in LaTeX buffers",
  callback = function(args)
    local bo = vim.bo[args.buf]
    bo.indentexpr = ""
    bo.indentkeys = ""
    bo.autoindent = true
    bo.smartindent = false
    bo.cindent = false
  end,
})

-- LSP
vim.pack.add {
  { src = 'https://github.com/neovim/nvim-lspconfig' },
}
-- Lua
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
})
vim.lsp.enable('lua_ls')
-- Python
vim.lsp.enable({ 'pyrefly', 'ruff' })
-- Elm
vim.lsp.enable('elmls')
