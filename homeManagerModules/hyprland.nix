{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    hyprland.enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    # nixpkgs.overlays = [
    #   (final: prev: {
    #     waybar = prev.waybar.overrideAttrs (old: {
    #       src = pkgs.fetchFromGitHub {
    #         owner = "Alexays";
    #         repo = "Waybar";
    #         rev = "f409f53131b3061a4c8f08f3a39abe1e3417ff4b";
    #         hash = "sha256-CbvStVJ0bzrIHh2CkaM2epMB1AoTJMAw+Mx/ORJTOdY=";
    #       };
    #     });
    #   })
    # ];

    programs = {
      fuzzel = {
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

      waybar = {
        enable = true;
        settings = {
          mainBar = {
            "modules-left" = [ "hyprland/workspaces" ];
            "modules-center" = [
              "clock"
              "idle_inhibitor"
            ];
            "modules-right" = [
              "tray"
              "pulseaudio"
            ];
            "network" = {
              "format-wifi" = "{essid} ({signalStrength}%) ";
              "format-ethernet" = "{ifname} ";
              "format-disconnected" = "";
              "max-length" = 50;
            };
            "idle_inhibitor" = {
              "format" = "{icon}";
              "format-icons" = {
                "activated" = "";
                "deactivated" = "";
              };
            };
            "tray" = {
              "icon-size" = 15;
              "spacing" = 10;
            };
            "pulseaudio" = {
              "format" = "{volume}% {icon} ";
              "format-bluetooth" = "{volume}% {icon} {format_source}";
              "format-bluetooth-muted" = " {icon} {format_source}";
              "format-muted" = "0% {icon} ";
              "format-source" = "{volume}% ";
              "format-source-muted" = "";
              "format-icons" = {
                "headphone" = "";
                "hands-free" = "";
                "headset" = "";
                "phone" = "";
                "portable" = "";
                "car" = "";
                "default" = [
                  ""
                  ""
                  ""
                ];
              };
              "on-click" = "pavucontrol";
            };
          };
        };
        style = ./waybar.css;
      };
    };

    services = {
      mako.enable = true;
      hypridle = {
        enable = true;
        settings = {
          listener = [
            {
              timeout = 330;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
          ];
        };
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        monitor = "DP-3, preferred, auto, 1.5";
        xwayland.force_zero_scaling = true;

        exec-once = [
          "waybar"
          "variety"
          "blueman-applet"
          "fcitx5 -d"
          "ELECTRON_OZONE_PLATFORM_HINT=auto 1password --silent"
          "hyprctl setcursor macOS 24"
          "systemctl --user start hyprpolkitagent"
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

        misc = {
          force_default_wallpaper = -1; # Remove default wallpaper
          disable_hyprland_logo = true;
          enable_anr_dialog = false; # Disable non-responsive app dialogues
        };

        "$mod" = "SUPER";

        bind = [
          "$mod, T, exec, ghostty"
          "$mod, Z, exec, zen"
          "$mod, D, exec, dolphin"
          "$mod, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
          "$mod SHIFT, Z, exec, zen --private-window"
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

        bindel =
          let
            bright_cmd = "ddcutil --bus 14 --sleep-multiplier 0.1 setvcp 10";
          in
          [
            # For my HHKB, SCROLL_LOCK & PAUSE correspond to macOS's brightness ctl
            ", SCROLL_LOCK, exec, ${bright_cmd} - 5"
            ", PAUSE, exec, ${bright_cmd} + 5"
            ", XF86MonBrightnessDown, exec, ${bright_cmd} - 5"
            ", XF86MonBrightnessUp, exec, ${bright_cmd} + 5"

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
      variety
      swww
    ];
  };
}
