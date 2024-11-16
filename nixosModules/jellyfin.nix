{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    jellyfin.enable = lib.mkEnableOption "enable jellyfin";
    jellyfin.username = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = lib.mkIf config.jellyfin.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
      user = config.jellyfin.username;
    };

    environment.systemPackages = [
      pkgs.jellyfin
      pkgs.jellyfin-web
      pkgs.jellyfin-ffmpeg
    ];
  };
}
