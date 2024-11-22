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
    nixpkgs.overlays = [
      (final: prev: {
        rclone = prev.rclone.overrideAttrs (old: {
          src = pkgs.fetchFromGitHub {
            owner = "rclone";
            repo = "rclone";
            rev = "d65d1a44b36b259ff92d35844fc3b56e6f6f57cf";
            hash = "sha256-doJYA0mIOsf6zvtiFaOCSyJEbXPgjXpwVQUgUC5Lpm8=";
          };
          vendorHash = "sha256-Mdh6/4B/B/JsdMwO/1aopuJHE4020nYtBC4GdvdKJvg=";
        });
      })
    ];

    home.packages = with pkgs; [
      rclone
      rclone-browser
    ];
  };
}
