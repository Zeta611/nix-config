{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    utilities.enable = lib.mkEnableOption "enable utilities";
  };

  config = lib.mkIf config.utilities.enable {
    home.packages = with pkgs; [
      transmission_4-gtk
      tldr
    ];
  };
}
