{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    ddcutil.enable = lib.mkEnableOption "enable ddcutil";
  };

  config = lib.mkIf config.ddcutil.enable {
    # https://discourse.nixos.org/t/how-to-enable-ddc-brightness-control-i2c-permissions/20800/6
    hardware.i2c.enable = true;

    environment.systemPackages = with pkgs; [
      ddcutil
      ddcui
    ];
  };
}
