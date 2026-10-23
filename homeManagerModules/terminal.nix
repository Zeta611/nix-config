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
        enable = false;
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
          v = "vim";
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
          fish_add_path $HOME/.cargo/bin
          fish_add_path $HOME/.npm-global/bin

          fish_config theme choose catppuccin-latte

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
          # Local secrets (not in git). See secrets.fish.example.
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
          git_status = {
            use_git_executable = true;
          };
        };
      };

      eza.enable = true;

      zoxide.enable = true;
      bat = {
        enable = true;
        config = {
          theme = "Catppuccin Latte";
        };
        themes."Catppuccin Latte" = {
          src = ./bat_catppuccin_latte.tmTheme;
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
          # https://github.com/catppuccin/fzf
          "--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39"
          "--color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78"
          "--color=marker:#7287fd,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"
          "--color=selected-bg:#bcc0cc"
          "--color=border:#9ca0b0,label:#4c4f69"
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
      nodejs
      pnpm
      opam
      bison
      flex
    ];

    xdg.configFile = {
      "fish/themes/catppuccin-latte.theme".text = builtins.readFile ./fish_catppuccin_latte.theme;
      # Example only — copy to secrets.fish (gitignored / local) and fill in values.
      "fish/secrets.fish.example".source = ./secrets.fish.example;
      "lazygit/config.yml".text = builtins.readFile ./lazygit_catppuccin_latte.yml;
      "wezterm/wezterm.lua".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/homeManagerModules/wezterm.lua";
    };
  };
}
