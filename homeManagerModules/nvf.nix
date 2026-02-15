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
      };
    };
  };
}
