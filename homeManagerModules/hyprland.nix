{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  options = {
    hyprland.enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "Noto Sans CJK KR:size=24";
          use-bold = true;
          prompt = "𝝺 ";
          width = 40;
          tabs = 4;
        };
        colors = {
          background = "d0d5e3ff";
          text = "3760bfff";
          match = "188092ff";
          selection = "b3b8d1ff";
          selection-match = "188092ff";
          selection-text = "3760bfff";
          border = "4094a3ff";
        };
      };
    };
    services.mako.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        monitor = "DP-3, preferred, auto, 1.5";
        xwayland.force_zero_scaling = true;

        exec-once = [
          "hyprpanel"
          "blueman-applet"
          "fcitx5 -d"
          "ELECTRON_OZONE_PLATFORM_HINT=auto 1password --silent"
          "hyprctl setcursor macOS 24"
          "systemctl --user start hyprpolkitagent"
          "mpvpaper -p '*' ~/Videos/wallpapers/ -o 'no-audio shuffle loop-playlist'"
          "wl-paste --type text --watch cliphist store"
        ];

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 0;
        };

        decoration = {
          rounding = 10;
        };

        input = {
          natural_scroll = true;
        };

        "$mod" = "SUPER";

        bind =
          [
            "$mod, T, exec, wezterm start"
            "$mod, Z, exec, zen"
            "$mod, D, exec, dolphin"
            "$mod, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
            "$mod SHIFT, Z, exec, zen --private-window"
            "$mod, J, exec, jellyfinmediaplayer --disable-gpu"
            "$mod, SPACE, exec, fuzzel"

            "$mod, C, killactive"
            "$mod, Q, exit"

            "$mod SHIFT, F, fullscreen"
            "$mod, F, togglefloating"
            "$mod SHIFT, C, centerwindow"

            "$mod, H, movefocus, l"
            "$mod, J, movefocus, d"
            "$mod, K, movefocus, u"
            "$mod, L, movefocus, r"
            "$mod SHIFT, H, movewindoworgroup, l"
            "$mod SHIFT, J, movewindoworgroup, d"
            "$mod SHIFT, K, movewindoworgroup, u"
            "$mod SHIFT, L, movewindoworgroup, r"

            "$mod, code:47, togglegroup"
            "$mod CONTROL, J, changegroupactive, f"
            "$mod CONTROL, K, changegroupactive, b"

            "$mod, TAB, workspace, +1"
            "$mod SHIFT, TAB, workspace, -1"
          ]
          ++ (builtins.concatLists (
            builtins.genList (
              i:
              let
                ws = i + 1;
              in
              [
                # code:10=`1` -- code:19=`0`
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            ) 9
          ));

        bindel = [
          # For my HHKB, SCROLL_LOCK & PAUSE correspond to macOS's brightness ctl
          ", SCROLL_LOCK, exec, bright -5"
          ", PAUSE, exec, bright +5"
          ", XF86MonBrightnessDown, exec, bright -5"
          ", XF86MonBrightnessUp, exec, bright +5"

          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ];

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };
    };

    home.sessionVariables.NIXOS_OZONE_WL = "1";
    home.pointerCursor = {
      name = "macOS";
      package = pkgs.apple-cursor;
      size = 24;
      x11.enable = true;
      gtk.enable = true;
    };

    home.packages = with pkgs; [
      font-awesome
      hyprpolkitagent
      mpvpaper
      hyprpicker
      inputs.hyprpanel.packages.${pkgs.system}.default
      (pkgs.writeScriptBin "bright" (builtins.readFile ./bright.fish))
    ];
  };
}
