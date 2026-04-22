{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.nvf.homeManagerModules.default
    ./direnv.nix
    ./terminal.nix
    ./nvf.nix
    ./texlive.nix
    ./cursor.nix
  ];
}
