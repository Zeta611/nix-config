{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    nvf.enable = lib.mkEnableOption "enable nvf";
  };

  config = lib.mkIf config.nvf.enable {
    programs.nvf = {
      enable = true;
      settings = {
        vim.viAlias = false;
        vim.vimAlias = true;
        vim.lsp = {
          enable = true;
        };
        vim.additionalRuntimePaths = ["~/.config/nvim"];

        vim.fzf-lua.enable = true;
        vim.extraPackages = with pkgs; [ fd ripgrep ];
        # NVF uses Space as the default leader. :FzfLua lists all pickers.
        vim.keymaps = [
          {
            key = "<leader>ff";
            mode = "n";
            action = "<cmd>FzfLua files<CR>";
            desc = "Find files";
          }
          {
            key = "<leader>fg";
            mode = "n";
            action = "<cmd>FzfLua live_grep<CR>";
            desc = "Search file contents";
          }
          {
            key = "<leader>fb";
            mode = "n";
            action = "<cmd>FzfLua buffers<CR>";
            desc = "Find buffers";
          }
          {
            key = "<leader>fr";
            mode = "n";
            action = "<cmd>FzfLua oldfiles<CR>";
            desc = "Find recent files";
          }
        ];

        # Disable automatic indentation in LaTeX buffers; indent manually.
        # The built-in indent/tex.vim sets indentexpr=GetTeXIndent() and adds
        # { [ ( to indentkeys, which re-indents on an opening brace and after
        # \begin{...}. A FileType autocmd runs after it, so clearing these wins.
        vim.autocmds = [
          {
            event = ["FileType"];
            pattern = ["tex"];
            desc = "Disable automatic indentation in LaTeX buffers";
            callback = lib.generators.mkLuaInline ''
              function(args)
                local bo = vim.bo[args.buf]
                bo.indentexpr = ""    -- no smart/context indentation
                bo.indentkeys = ""    -- no re-indent on { [ ( \item ...
                bo.autoindent = true  -- keep previous line's indent on Enter
                bo.smartindent = false
                bo.cindent = false
              end
            '';
          }
        ];
      };
    };
  };
}
