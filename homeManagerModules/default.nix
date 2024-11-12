{ pkgs, lib, ... }:

{
  imports = [
    ./hyprland.nix
    ./dolphin.nix
    ./terminal.nix
    ./neovim.nix
    ./utilities.nix
  ];
}
