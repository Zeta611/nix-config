{ ... }:

{
  imports = [
    ./bluetooth.nix
    ./nvidia.nix
    ./pipewire.nix
    ./ddcutil.nix
    ./_1password.nix
    ./jellyfin.nix
  ];
}
