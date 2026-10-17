{ 
  inputs,
  ...
}:

{
  imports = [
    ./common.nix
    ./neovim.nix
    ./aerospace.nix
    ./sketchybar.nix
    ./zen-browser.nix
  ];
}

