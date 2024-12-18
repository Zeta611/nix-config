{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  options = {
    direnv.enable = lib.mkEnableOption "enable direnv";
  };

  config = lib.mkIf config.direnv.enable {
    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
