{ ... }:

{
  imports = [
    ./bluetooth.nix
    ./nvidia.nix
    ./pipewire.nix
    ./ddcutil.nix
    ./solaar.nix
    ./_1password.nix
    ./jellyfin.nix
    ./sabnzbd.nix
    ./samba.nix
    ./uxplay.nix
    ./avahi.nix
    ./diskutils.nix
  ];
}
