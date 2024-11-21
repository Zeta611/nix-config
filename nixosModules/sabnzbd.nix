{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    sabnzbd.enable = lib.mkEnableOption "enable sabnzbd";
    sabnzbd.username = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = lib.mkIf config.sabnzbd.enable {
    services.sabnzbd = {
      enable = true;
      openFirewall = true;
      user = config.sabnzbd.username;
    };
    environment.systemPackages = [
      pkgs.sabnzbd
    ];
  };
}
