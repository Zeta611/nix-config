{
  lib,
  config,
  ...
}:

{
  options = {
    avahi.enable = lib.mkEnableOption "enable avahi";
  };

  config = lib.mkIf config.avahi.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        userServices = true;
        domain = true;
      };
    };
  };
}
