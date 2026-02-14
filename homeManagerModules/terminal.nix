{
  pkgs,
  lib,
  config,
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
      };
      fish = {
        enable = true;
        functions = {
          gi = "curl -sL https://www.gitignore.io/api/$argv";
          zl = "z $argv && eza --icons -alh";
          fish_greeting = "fastfetch";
          starship_transient_prompt_func = "starship module character";
          starship_transient_rprompt_func = "starship module time";
        };
        shellAbbrs = {
          c = "cursor";
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
          imgcat = "wezterm imgcat";
        };
        shellAliases = {
          l = "eza --icons -alh";
          la = "eza --icons -a";
          tree = "eza --tree --icons";
        };
        shellInit = ''
          fish_add_path $HOME/.local/bin

          fish_config theme choose tokyonight_day

          if test -d /opt/homebrew
            fish_add_path -a /opt/homebrew/bin
            fish_add_path -a /opt/homebrew/sbin
          end

          if test -d $HOME/.local/bin/sketch-1.7.6/sketch-frontend
            fish_add_path -a $HOME/.local/bin/sketch-1.7.6/sketch-frontend
            set -gx SKETCH_HOME $HOME/.local/bin/sketch-1.7.6/sketch-frontend/runtime
          end
        '';
        interactiveShellInit = ''
          direnv hook fish | source
          if test -f $XDG_CONFIG_HOME/fish/secrets.fish
              source $XDG_CONFIG_HOME/fish/secrets.fish
          end
        '';
      };

      starship = {
        enable = true;
        enableTransience = true;
        settings = {
          format = "$all$time$line_break$jobs$battery$status$shell$character";
          character = {
            success_symbol = "[𝝺](bold green)";
            error_symbol = "[𝝮](bold red)";
          };
          time = {
            disabled = false;
          };
        };
      };

      eza.enable = true;

      zoxide.enable = true;
      bat = {
        enable = true;
        config = {
          theme = "tokyonight_day";
        };
        themes = {
          tokyonight_day = {
            src = pkgs.fetchFromGitHub {
              owner = "folke";
              repo = "tokyonight.nvim";
              rev = "c2725eb6d086c8c9624456d734bd365194660017";
              sha256 = "sha256-vKXlFHzga9DihzDn+v+j3pMNDfvhYHcCT8GpPs0Uxgg=";
            };
            file = "extras/sublime/tokyonight_day.tmTheme";
          };
        };
      };
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
      # thefuck.enable = true;
      fastfetch.enable = true;
    };

    home.packages = with pkgs; [
      lazygit
      nerd-fonts.jetbrains-mono
      nixfmt
      bison
      flex
    ];

    xdg.configFile = {
      "fish/themes/tokyonight_day.theme".text = builtins.readFile ./fish_tokyonight_day.theme;
      "lazygit/config.yml".text = builtins.readFile ./lazygit_tokyonight_day.yml;
      "wezterm/colors/tokyonight_day.toml".text = builtins.readFile ./wezterm_tokyonight_day.toml;
      "wezterm/wezterm.lua".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/homeManagerModules/wezterm.lua";
    };
  };
}
