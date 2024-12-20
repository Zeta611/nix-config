{
  pkgs,
  inputs,
  osConfig,
  ...
}:

{
  home.username = "jay";
  home.homeDirectory = "/Users/jay";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  imports = [
    inputs.self.outputs.homeManagerModules.darwin
  ];

# :FIXME: Integrate with NixOS git config
  programs.git.enable = true;

  terminal.enable = true;
  direnv.enable = true;
  aerospace.enable = true;
  sketchybar.enable = true;

  xdg.enable = true;

  programs.home-manager.enable = true;
}
