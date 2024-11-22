{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  options = {
    libreoffice.enable = lib.mkEnableOption "enable libreoffice";
  };

  config = lib.mkIf config.libreoffice.enable {
    home.packages = with pkgs; [
      libreoffice-qt6-fresh
      hunspell
      hunspellDicts.en_US
    ];
  };
}
