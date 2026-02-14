{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    rclone.enable = lib.mkEnableOption "enable rclone";
  };

  config = lib.mkIf config.rclone.enable {
    home.packages = with pkgs; [
      rclone
      rclone-browser
    ];
  };
}
