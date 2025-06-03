{
  pkgs,
  lib,
  config,
  hostName,
  ...
}:

{
  options = {
    ghostty.enable = lib.mkEnableOption "enable ghostty";
  };

  config = lib.mkIf config.ghostty.enable {
    programs = {
      ghostty = {
        enable = true;
        enableFishIntegration = true;
      };
    };
    xdg.configFile = {
      "ghostty/config".source =
        if hostName == "jay-nixos" then
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/homeManagerModules/ghostty_config_nixos"
        else
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/homeManagerModules/ghostty_config";

    };
  };
}
