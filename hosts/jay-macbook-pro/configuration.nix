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

  nixpkgs.config.allowUnfree = true;

  # This is required for the fish shell to work properly via nix-darwin
  # https://github.com/LnL7/nix-darwin/issues/122#issuecomment-1786729187
  programs.fish.enable = true;

  programs._1password.enable = true;
  programs._1password-gui.enable = true;

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      hostName = "jay-macbook";
    };
    users = {
      "jay" = import ./home.nix;
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    casks = [
      "ghostty"
      "wispr-flow"
    ];
    # Oh boy...
    masApps = {
      KakaoTalk = 869223134;
      Keynote = 409183694;
    };
  };

  system.defaults = {
    NSGlobalDomain = {
      AppleICUForce24HourTime = true;
      AppleScrollerPagingBehavior = true;
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 14;
      KeyRepeat = 1;
      NSWindowShouldDragOnGesture = true;
      "com.apple.mouse.tapBehavior" = 1; # tap to click
    };
    dock = {
      autohide = true;
      largesize = 64;
      magnification = true;
      scroll-to-open = true;
      slow-motion-allowed = true;
      tilesize = 32;
    };
    finder = {
      AppleShowAllExtensions = true;
      FXDefaultSearchScope = "SCcf"; # current folder
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "clmv"; # column view
      NewWindowTarget = "Documents";
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXEnableColumnAutoSizing = true;
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = true;
      _FXSortFoldersFirstOnDesktop = true;
    };
    iCal = {
      "TimeZone support enabled" = true;
      "first day of week" = "Monday";
    };
    trackpad = {
      Clicking = true;
      TrackpadFourFingerVertSwipeGesture = 2;
      TrackpadThreeFingerDrag = true;
    };
    CustomUserPreferences."com.apple.symbolichotkeys".AppleSymbolicHotKeys = {
      "64".enabled = false; # disable cmd+space for Spotlight Search
      "61" = {
        enabled = true;
        value = {
          # cmd+space = space (ASCII 32, virtual keycode 49) cmd (0x100000=1048576)
          parameters = [32 49 1048576];
          type = "standard";
        };
      };
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
