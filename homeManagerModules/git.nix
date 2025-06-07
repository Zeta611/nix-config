{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  options = {
    git.enable = lib.mkEnableOption "enable git";
  };

  config = lib.mkIf config.git.enable {
    programs = {
      git = {
        enable = true;
        userName = "Jay Lee";
        userEmail = "jaeho.lee@snu.ac.kr";
        extraConfig = {
          commit.gpgsign = true;
          user.signingkey = "630C65D0299CF2D6!";
          init.defaultBranch = "main";
        };
      };
      gpg.enable = true;
    };

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentry.package = pkgs.pinentry-gnome3;
    };

  };
}
