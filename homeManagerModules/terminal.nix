{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  options = {
    terminal.enable = lib.mkEnableOption "enable terminal";
  };

  config = lib.mkIf config.terminal.enable {
    programs = {
      wezterm = {
        enable = true;
        package = inputs.wezterm.packages.${pkgs.system}.default;
        extraConfig = builtins.readFile ./wezterm.lua;
      };

      fish = {
        enable = true;
        functions = {
          gi = "curl -sL https://www.gitignore.io/api/$argv";
          fish_greeting = "fastfetch";
        };
        shellAbbrs = {
          v = "nvim";
          gs = "git status";
          gst = "git stash";
          ga = "git add";
          gc = "git commit -S -m";
          gca = "git commit -S --amend -m";
          gco = "git checkout";
          gp = "git push";
          gpf = "git push --force-with-lease";
          gl = "git pull";
          gg = "git log";
          cat = "bat -p";
          lg = "lazygit";
        };
        shellAliases = {
          l = "eza --icons -alh";
          la = "eza --icons -a";
          tree = "eza --tree --icons";
        };
        interactiveShellInit = ''
          if test -f $XDG_CONFIG_HOME/fish/secrets.fish
              source $XDG_CONFIG_HOME/fish/secrets.fish
          end
        '';
      };

      starship = {
        enable = true;
      };

      git = {
        enable = true;
        userName = "Jay Lee";
        userEmail = "jaeho.lee@snu.ac.kr";
        extraConfig = {
          commit.gpgsign = true;
          user.signingkey = "630C65D0299CF2D6!";
          init.defaultBranch = "main";
        };
      };
      lazygit.enable = true;
      gpg.enable = true;
      eza.enable = true;

      zoxide.enable = true;
      bat.enable = true;
      fd.enable = true;
      fzf = {
        enable = true;
        defaultOptions = [
          "--info=inline-right"
          "--layout=reverse"
          "--border=none"
          "--ansi"
          "--color=bg+:#b7c1e3"
          "--color=bg:#d0d5e3"
          "--color=border:#4094a3"
          "--color=fg:#3760bf"
          "--color=gutter:#d0d5e3"
          "--color=header:#b15c00"
          "--color=hl+:#188092"
          "--color=hl:#188092"
          "--color=info:#8990b3"
          "--color=marker:#d20065"
          "--color=pointer:#d20065"
          "--color=prompt:#188092"
          "--color=query:#3760bf:regular"
          "--color=scrollbar:#4094a3"
          "--color=separator:#b15c00"
          "--color=spinner:#d20065"
        ];
      };
      ripgrep.enable = true;
      thefuck.enable = true;
      fastfetch.enable = true;
      direnv.enable = true;
    };

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };

    home.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      nixfmt-rfc-style
    ];

    xdg.configFile = {
      "fish/themes/tokyonight_day.theme".text = builtins.readFile ./fish_tokyonight_day.theme;
      "lazygit/config.yml".text = builtins.readFile ./lazygit_tokyonight_day.yml;
      "wezterm/colors/tokyonight_day.toml".text = builtins.readFile ./wezterm_tokyonight_day.toml;
    };
  };
}
