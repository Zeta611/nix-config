{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.neovim.enable = lib.mkEnableOption "enable Neovim";

  config = lib.mkIf config.neovim.enable {
    programs.neovim = {
      enable = true;
      viAlias = false;
      vimAlias = true;
      withRuby = false;
      withPython3 = false;
      extraPackages = with pkgs; [
        # Search
        fd
        ripgrep
        fzf
        # Python
        pyrefly
        ruff
        # Lua
        lua-language-server
      ];
    };

    # Editable Lua files; Neovim loads init.lua through its normal startup.
    xdg.configFile = {
      "nvim/init.lua".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/homeManagerModules/neovim-config/init.lua";
      "nvim/plugin/fzf.lua".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/homeManagerModules/neovim-config/plugin/fzf.lua";
      "nvim/plugin/overleaf-autosync.lua".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/homeManagerModules/neovim-config/plugin/overleaf-autosync.lua";
    };
  };
}
