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
