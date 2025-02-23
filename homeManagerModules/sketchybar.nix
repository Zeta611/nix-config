{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    sketchybar.enable = lib.mkEnableOption "enable sketchybar";
  };

  config = lib.mkIf config.sketchybar.enable {
    home.file."./.config/sketchybar/" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/homeManagerModules/sketchybar-config";
      recursive = true;
    };
  };
}
