vim.pack.add({
  { src = "https://github.com/joongwon/overleaf-autosync.nvim" },
})

require("overleaf_autosync").setup({
  whitelist_file = ".overleafwl",
  -- auto_push = true,
  debounce_ms = 1500,
})
