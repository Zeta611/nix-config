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
    programs.fuzzel = {
      enable = true;
      settings = {
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
    programs.waybar.enable = true;
    services.mako.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        #env = [
        #  "XCURSOR_THEME,macOS"
        #  "XCURSOR_SIZE,200"
        #  "QT_CURSOR_THEME,macOS"
        #  "QT_CURSOR_SIZE,200"
        #];

        monitor = "DP-3, preferred, auto, 1.5";

        exec-once = [
          "waybar & blueman-applet"
          "hyprctl setcursor macOS 24"
          "systemctl --user start hyprpolkitagent"
        ];

        input = {
          natural_scroll = true;
        };

        "$mod" = "SUPER";

        bind =
          [
            "$mod, T, exec, wezterm start"
            "$mod, SPACE, exec, fuzzel"
            "$mod, C, killactive"
            "$mod, Q, exit"
            "$mod, F, togglefloating"

            "$mod, h, movefocus, l"
            "$mod, j, movefocus, d"
            "$mod, k, movefocus, u"
            "$mod, l, movefocus, r"
          ]
          ++ (builtins.concatLists (
            builtins.genList (
              i:
              let
                ws = i + 1;
              in
              [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            ) 9
          ));

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
    ];
  };
}
