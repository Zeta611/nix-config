vim.pack.add({
  { src = "https://github.com/ibhagwan/fzf-lua" },
})

local fzf = require("fzf-lua")
local excludes = { ".git", ".jj", "node_modules", ".DS_Store", ".hai" }

local fd_opts = "--color=never --type f --type l"
local rg_globs = ""
for _, e in ipairs(excludes) do
  fd_opts = fd_opts .. " --exclude " .. e
  rg_globs = rg_globs .. ' -g "!' .. e .. '"'
end

fzf.setup({
  files = {
    fd_opts = fd_opts,
    rg_opts = "--color=never --files" .. rg_globs, -- fallback if fd is missing
  },
  grep = {
    rg_opts = "--column --line-number --no-heading --color=always --smart-case "
        .. "--max-columns=4096" .. rg_globs .. " -e",
  },
})

local map = function(key, action, desc)
  vim.keymap.set("n", key, action, { desc = desc })
end
map("<leader><space>", fzf.files, "Find files")
map("<leader>/", fzf.live_grep, "Live grep")
map("<leader>b", fzf.buffers, "List buffers")
map("<leader>fr", fzf.oldfiles, "Find recent files")
map("<leader>fn", function()
  fzf.files({ cwd = vim.fn.expand("~/nix"), follow = true })
end, "Find Nix files")
