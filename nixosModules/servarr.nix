{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    servarr.enable = lib.mkEnableOption "enable servarr";
    servarr.username = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = lib.mkIf config.servarr.enable {
    services = {
      radarr = {
        enable = true;
        openFirewall = true;
        user = config.servarr.username;
      };
      sonarr = {
        enable = true;
        openFirewall = true;
        user = config.servarr.username;
      };
      prowlarr = {
        enable = true;
        openFirewall = true;
      };
      transmission = {
        enable = true;
        openFirewall = true;
        user = config.servarr.username;
        settings = {
          download-dir = "/data/torrents/";
          incomplete-dir = "/data/torrents/incomplete/";
        };
      };
    };
  };
}
