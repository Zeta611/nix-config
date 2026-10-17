{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./direnv.nix
    ./terminal.nix
    ./texlive.nix
    ./cursor.nix
  ];
}
