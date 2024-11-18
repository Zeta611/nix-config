{
  lib,
  config,
  ...
}:

{
  options = {
    samba.enable = lib.mkEnableOption "enable samba";
  };

  config = lib.mkIf config.samba.enable {
    services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        private = {
          path = "/";
          "read only" = false;
          browseable = true;
          "guest ok" = false;
        };
      };
    };
  };
}
