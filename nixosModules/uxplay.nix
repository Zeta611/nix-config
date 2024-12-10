{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    uxplay.enable = lib.mkEnableOption "enable uxplay";
  };

  config = lib.mkIf config.uxplay.enable {
    networking.firewall.allowedTCPPorts = [
      7000
      7001
      7100
    ];
    networking.firewall.allowedUDPPorts = [
      5353
      6000
      6001
      7011
    ];

    services.avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
        userServices = true;
        domain = true;
      };
    };

    environment.systemPackages = with pkgs; [
      uxplay
    ];
  };
}
