{
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.home-manager.darwinModules.default ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.vim
    # inputs.wezterm.packages.${pkgs.system}.default
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.fish.enable = true;

  users.users.jay = {
    home = "/Users/jay";
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    users = {
      "jay" = import ./home.nix;
    };
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
