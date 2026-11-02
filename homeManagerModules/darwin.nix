{ 
  inputs,
  ...
}:

{
  imports = [
    ./common.nix
    ./neovim.nix
    ./aerospace.nix
    ./ghostty.nix
    ./sketchybar.nix
    ./zen-browser.nix
  ];

  # Copy app bundles instead of symlinking them so Spotlight indexes them.
  targets.darwin.linkApps.enable = false;
  targets.darwin.copyApps.enable = true;
}

