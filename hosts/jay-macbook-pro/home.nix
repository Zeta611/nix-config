{
  pkgs,
  config,
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
    inputs.self.outputs.homeModules.darwin
  ];

  programs = {
    git = {
      enable = true;
      signing = {
        key = "~/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
      settings = {
        user.name = "Jay Lee";
        user.email = "jaeho.lee@snu.ac.kr";
        commit.gpgsign = true;
        init.defaultBranch = "main";
        gpg.format = "ssh";
      };
    };
    gpg.enable = true;
    ssh = {
      enable = true;
      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_ed25519";
          addKeysToAgent = "yes";
          extraOptions = {
            UseKeychain = "yes"; # macOS Keychain integration
          };
        };
      };
    };
  };

  programs.java.enable = true;

  programs.discord = {
    enable = true;
    settings.SKIP_HOST_UPDATE = true;
  };

  terminal.enable = true;
  claude-code.enable = true;
  direnv.enable = true;
  aerospace.enable = true;
  sketchybar.enable = false;
  texlive.enable = true;
  nvf.enable = true;
  zen-browser.enable = true;

  home.packages = with pkgs; [
    zoom-us
    slack
    raycast
    bartender
    istat-menus
  ];

  xdg.enable = true;
  # :NOTE: Temporary until full migration of homebrew
  xdg.configFile = {
    "ghostty/config".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/homeManagerModules/ghostty_config";
  };

  programs.home-manager.enable = true;
}
