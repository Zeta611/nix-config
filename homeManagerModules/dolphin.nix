{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    dolphin.enable = lib.mkEnableOption "enable dolphin";
  };

  config = lib.mkIf config.dolphin.enable {
    programs.plasma = {
      enable = true;
    };
    programs.konsole = {
      enable = true;
      defaultProfile = "default";
      profiles = {
        default = {
          command = "fish -l";
          font = {
            name = "JetBrains Mono";
            size = 12;
          };
        };
      };
    };
    # I need to manually place this... (copied from the version `libsForQt5.kservice`)
    xdg.configFile."menus/applications.menu".text = builtins.readFile ./applications.menu;
    home.packages =
      with pkgs;
      (with kdePackages; [
        kio
        kio-extras
        breeze-icons
        qtsvg # for icons
        ffmpegthumbs # for previews
        dolphin
        konsole
        kservice # for applications list
        shared-mime-info
      ]);
  };
}
