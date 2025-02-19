{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    wine.enable = lib.mkEnableOption "enable wine";
  };

  config = lib.mkIf config.wine.enable {
    environment.systemPackages = with pkgs; [
      wineWowPackages.stable
    ];
  };
}
