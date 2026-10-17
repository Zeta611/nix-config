vim.pack.add({
  { src = "https://github.com/ibhagwan/fzf-lua" },
})

local fzf = require("fzf-lua")
fzf.setup({})
local map = function(key, action, desc)
  vim.keymap.set("n", key, action, { desc = desc })
end
map("<leader>ff", fzf.files, "Find files")
map("<leader>fg", fzf.live_grep, "Search file contents")
map("<leader>fb", fzf.buffers, "Find buffers")
map("<leader>fr", fzf.oldfiles, "Find recent files")
-- Preserve the existing short mappings without prefix conflicts with ff/fb/nd.
map("<leader>g", fzf.live_grep, "Live grep")
map("<leader>b", fzf.buffers, "List buffers")
map("<leader>fn", function()
  fzf.files({ cwd = vim.fn.expand("~/nix"), follow = true })
end, "Find Nix files")
