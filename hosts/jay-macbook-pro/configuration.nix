{
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.home-manager.darwinModules.default ];

  system.primaryUser = "jay";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.vim
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  users.users.jay = {
    home = "/Users/jay";
  };

  # This is required for the fish shell to work properly via nix-darwin
  # https://github.com/LnL7/nix-darwin/issues/122#issuecomment-1786729187
  programs.fish.enable = true;

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      hostName = "jay-macbook";
    };
    users = {
      "jay" = import ./home.nix;
    };
  };

  services.sketchybar = {
    enable = false;
    package = pkgs.sketchybar;
    extraPackages = [
      pkgs.lua5_4_compat
    ];
  };

  system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
