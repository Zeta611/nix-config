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
    home.packages = with pkgs; [
      kdePackages.kio
      kdePackages.kio-extras
      kdePackages.breeze-icons
      kdePackages.dolphin-plugins
      dolphin
      konsole
    ];
  };
}
