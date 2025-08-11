{ pkgs, lib, config, ... }:

let
  cursor-cli = pkgs.callPackage ./package.nix { };
in {
  options.cursor-cli.enable = lib.mkEnableOption "enable cursor-cli";

  config = lib.mkIf config.cursor-cli.enable {
    home.packages = [ cursor-cli ];
  };
}
