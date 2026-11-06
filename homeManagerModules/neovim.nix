{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.neovim.enable = lib.mkEnableOption "enable Neovim";

  config = lib.mkIf config.neovim.enable {
    home.packages = [
      (pkgs.writeShellScriptBin "cmux-nvim-open"
        (builtins.readFile ./neovim-config/cmux-nvim-open))
    ];

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
        # Web
        # Elm
        elmPackages.elm-language-server
        # JS, TS, HTML, CSS, etc.
        biome
        typescript
        svelte-language-server
        # Rust
        rust-analyzer
      ];
    };

    # Editable Lua files; Neovim loads init.lua through its normal startup.
    xdg.configFile =
      let
        link =
          path:
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/homeManagerModules/neovim-config/${path}";
        pluginFiles = lib.filterAttrs (
          name: type: type == "regular" && lib.hasSuffix ".lua" name
        ) (builtins.readDir ./neovim-config/plugin);
      in
      {
        "nvim/init.lua".source = link "init.lua";
      }
      // lib.mapAttrs' (
        name: _: lib.nameValuePair "nvim/plugin/${name}" { source = link "plugin/${name}"; }
      ) pluginFiles;
  };
}
