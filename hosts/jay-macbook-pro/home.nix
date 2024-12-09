{
  pkgs,
  inputs,
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
    # inputs.self.outputs.homeManagerModules.default
  ];

  programs = {
    wezterm = {
      enable = true;
      package = inputs.wezterm.packages.${pkgs.system}.default;
      extraConfig = builtins.readFile ./wezterm.lua;
    };
  };

  programs.home-manager.enable = true;
}
