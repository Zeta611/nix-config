{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    solaar.enable = lib.mkEnableOption "enable solaar";
  };

  config = lib.mkIf config.solaar.enable {
    services.solaar = {
      enable = true;
      package = pkgs.solaar;
      window = "hide";
      batteryIcons = "regular";
    };
  };
}
