{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/data" = {
    device = "/dev/hdd/data";
    fsType = "ext4";
  };

  networking.hostName = "jay-nixos";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;
  services.cloudflare-warp.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  # WARNING: This is temporary
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-6.0.428"
    "aspnetcore-runtime-6.0.36"
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  bluetooth.enable = true;
  hardware.graphics.enable = true;
  nvidia.enable = true;
  solaar.enable = true;
  _1password.enable = true;
  jellyfin = {
    enable = true;
    username = "jay";
  };
  sabnzbd = {
    enable = true;
    username = "jay";
  };
  servarr = {
    enable = true;
    username = "jay";
  };
  ddcutil.enable = true;
  samba.enable = true;
  diskutils.enable = true;
  avahi.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  security.polkit.enable = true;

  services.openssh.enable = true;
  services.printing.enable = true;

  pipewire.enable = true;

  uxplay.enable = true;

  wine.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    lshw
    wget
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  time.timeZone = "Asia/Seoul";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ko_KR.UTF-8";
      LC_IDENTIFICATION = "ko_KR.UTF-8";
      LC_MEASUREMENT = "ko_KR.UTF-8";
      LC_MONETARY = "ko_KR.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "ko_KR.UTF-8";
      LC_PAPER = "ko_KR.UTF-8";
      LC_TELEPHONE = "ko_KR.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  users.users.jay = {
    isNormalUser = true;
    description = "Jay Lee";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = [ ];
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    sharedModules = [
      inputs.plasma-manager.homeManagerModules.plasma-manager
    ];
    users = {
      "jay" = import ./home.nix;
    };
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "jay";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
