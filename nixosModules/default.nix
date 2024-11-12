{ pkgs, lib, ... }:

{
  imports = [
    ./bluetooth.nix
    ./nvidia.nix
    ./pipewire.nix
  ];
}
