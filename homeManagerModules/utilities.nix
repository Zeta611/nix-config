{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  options = {
    utilities.enable = lib.mkEnableOption "enable utilities";
  };

  config = lib.mkIf config.utilities.enable {
    home.packages = with pkgs; [
      transmission_4-gtk
      tealdeer
      inputs.zen-browser.packages."${system}".default
      chromium
      mpv
      clang
      deno
      oculante
      wl-clipboard
      cliphist
      jellyfin-mpv-shim
      zotero_7
    ];

    xdg.configFile = {
      "mpv/mpv.conf".text = ''
        vo=gpu-next
      '';
    };

    # xdg.desktopEntries."com.github.iwalton3.jellyfin-media-player" = {
    #   name = "Jellyfin Media Player";
    #   exec = "jellyfinmediaplayer --platform=xcb --scale-factor=1.5";
    #   icon = "com.github.iwalton3.jellyfin-media-player";
    #   terminal = false;
    #   type = "Application";
    #   categories = [
    #     "AudioVideo"
    #     "Video"
    #     "Player"
    #     "TV"
    #   ];
    #   settings = {
    #     StartupWMClass = "com.github.iwalton3.jellyfin-media-player";
    #   };
    # };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        # https://github.com/zen-browser/desktop/blob/499781baf15cbd33b2dba859dd2fb5cacf0e7869/AppDir/zen.desktop#L7
        "text/html" = "zen.desktop";
        "text/xml" = "zen.desktop";
        "application/xhtml+xml" = "zen.desktop";
        "x-scheme-handler/http" = "zen.desktop";
        "x-scheme-handler/https" = "zen.desktop";
        "application/x-xpinstall" = "zen.desktop";
        "application/pdf" = "zen.desktop";
        "application/json" = "zen.desktop";

        # https://github.com/woelper/oculante/blob/7e04c9282cf30547197ec5ff8a01fac534d369f0/res/oculante.desktop#L11
        "image/bmp" = "oculante.desktop";
        "image/gif" = "oculante.desktop";
        "image/vnd.microsoft.icon" = "oculante.desktop";
        "image/jpeg" = "oculante.desktop";
        "image/png" = "oculante.desktop";
        "image/pnm" = "oculante.desktop";
        "image/avif" = "oculante.desktop";
        "image/tiff" = "oculante.desktop";
        "image/webp" = "oculante.desktop";
        "image/svg+xml" = "oculante.desktop";
        "image/exr" = "oculante.desktop";
        "image/x-dcraw" = "oculante.desktop";
        "image/x-nikon-nef" = "oculante.desktop";
        "image/x-canon-cr2" = "oculante.desktop";
        "image/x-adobe-dng" = "oculante.desktop";
        "image/x-epson-erf" = "oculante.desktop";
        "image/x-fuji-raf" = "oculante.desktop";
        "image/x-sony-arw" = "oculante.desktop";
        "image/x-sony-srf" = "oculante.desktop";
        "image/x-sony-sr2" = "oculante.desktop";
        "image/x-panasonic-raw" = "oculante.desktop";

        # https://github.com/mpv-player/mpv/blob/70aaba71d6e3071a732069a1d222d1eb4293faf2/etc/mpv.desktop#L47
        "application/ogg" = "mpv.desktop";
        "application/x-ogg" = "mpv.desktop";
        "application/mxf" = "mpv.desktop";
        "application/sdp" = "mpv.desktop";
        "application/smil" = "mpv.desktop";
        "application/x-smil" = "mpv.desktop";
        "application/streamingmedia" = "mpv.desktop";
        "application/x-streamingmedia" = "mpv.desktop";
        "application/vnd.rn-realmedia" = "mpv.desktop";
        "application/vnd.rn-realmedia-vbr" = "mpv.desktop";
        "audio/aac" = "mpv.desktop";
        "audio/x-aac" = "mpv.desktop";
        "audio/vnd.dolby.heaac.1" = "mpv.desktop";
        "audio/vnd.dolby.heaac.2" = "mpv.desktop";
        "audio/aiff" = "mpv.desktop";
        "audio/x-aiff" = "mpv.desktop";
        "audio/m4a" = "mpv.desktop";
        "audio/x-m4a" = "mpv.desktop";
        "application/x-extension-m4a" = "mpv.desktop";
        "audio/mp1" = "mpv.desktop";
        "audio/x-mp1" = "mpv.desktop";
        "audio/mp2" = "mpv.desktop";
        "audio/x-mp2" = "mpv.desktop";
        "audio/mp3" = "mpv.desktop";
        "audio/x-mp3" = "mpv.desktop";
        "audio/mpeg" = "mpv.desktop";
        "audio/mpeg2" = "mpv.desktop";
        "audio/mpeg3" = "mpv.desktop";
        "audio/mpegurl" = "mpv.desktop";
        "audio/x-mpegurl" = "mpv.desktop";
        "audio/mpg" = "mpv.desktop";
        "audio/x-mpg" = "mpv.desktop";
        "audio/rn-mpeg" = "mpv.desktop";
        "audio/musepack" = "mpv.desktop";
        "audio/x-musepack" = "mpv.desktop";
        "audio/ogg" = "mpv.desktop";
        "audio/scpls" = "mpv.desktop";
        "audio/x-scpls" = "mpv.desktop";
        "audio/vnd.rn-realaudio" = "mpv.desktop";
        "audio/wav" = "mpv.desktop";
        "audio/x-pn-wav" = "mpv.desktop";
        "audio/x-pn-windows-pcm" = "mpv.desktop";
        "audio/x-realaudio" = "mpv.desktop";
        "audio/x-pn-realaudio" = "mpv.desktop";
        "audio/x-ms-wma" = "mpv.desktop";
        "audio/x-pls" = "mpv.desktop";
        "audio/x-wav" = "mpv.desktop";
        "video/mpeg" = "mpv.desktop";
        "video/x-mpeg2" = "mpv.desktop";
        "video/x-mpeg3" = "mpv.desktop";
        "video/mp4v-es" = "mpv.desktop";
        "video/x-m4v" = "mpv.desktop";
        "video/mp4" = "mpv.desktop";
        "application/x-extension-mp4" = "mpv.desktop";
        "video/divx" = "mpv.desktop";
        "video/vnd.divx" = "mpv.desktop";
        "video/msvideo" = "mpv.desktop";
        "video/x-msvideo" = "mpv.desktop";
        "video/ogg" = "mpv.desktop";
        "video/quicktime" = "mpv.desktop";
        "video/vnd.rn-realvideo" = "mpv.desktop";
        "video/x-ms-afs" = "mpv.desktop";
        "video/x-ms-asf" = "mpv.desktop";
        "audio/x-ms-asf" = "mpv.desktop";
        "application/vnd.ms-asf" = "mpv.desktop";
        "video/x-ms-wmv" = "mpv.desktop";
        "video/x-ms-wmx" = "mpv.desktop";
        "video/x-ms-wvxvideo" = "mpv.desktop";
        "video/x-avi" = "mpv.desktop";
        "video/avi" = "mpv.desktop";
        "video/x-flic" = "mpv.desktop";
        "video/fli" = "mpv.desktop";
        "video/x-flc" = "mpv.desktop";
        "video/flv" = "mpv.desktop";
        "video/x-flv" = "mpv.desktop";
        "video/x-theora" = "mpv.desktop";
        "video/x-theora+ogg" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
        "video/mkv" = "mpv.desktop";
        "audio/x-matroska" = "mpv.desktop";
        "application/x-matroska" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "audio/webm" = "mpv.desktop";
        "audio/vorbis" = "mpv.desktop";
        "audio/x-vorbis" = "mpv.desktop";
        "audio/x-vorbis+ogg" = "mpv.desktop";
        "video/x-ogm" = "mpv.desktop";
        "video/x-ogm+ogg" = "mpv.desktop";
        "application/x-ogm" = "mpv.desktop";
        "application/x-ogm-audio" = "mpv.desktop";
        "application/x-ogm-video" = "mpv.desktop";
        "application/x-shorten" = "mpv.desktop";
        "audio/x-shorten" = "mpv.desktop";
        "audio/x-ape" = "mpv.desktop";
        "audio/x-wavpack" = "mpv.desktop";
        "audio/x-tta" = "mpv.desktop";
        "audio/AMR" = "mpv.desktop";
        "audio/ac3" = "mpv.desktop";
        "audio/eac3" = "mpv.desktop";
        "audio/amr-wb" = "mpv.desktop";
        "video/mp2t" = "mpv.desktop";
        "audio/flac" = "mpv.desktop";
        "audio/mp4" = "mpv.desktop";
        "application/x-mpegurl" = "mpv.desktop";
        "video/vnd.mpegurl" = "mpv.desktop";
        "application/vnd.apple.mpegurl" = "mpv.desktop";
        "audio/x-pn-au" = "mpv.desktop";
        "video/3gp" = "mpv.desktop";
        "video/3gpp" = "mpv.desktop";
        "video/3gpp2" = "mpv.desktop";
        "audio/3gpp" = "mpv.desktop";
        "audio/3gpp2" = "mpv.desktop";
        "video/dv" = "mpv.desktop";
        "audio/dv" = "mpv.desktop";
        "audio/opus" = "mpv.desktop";
        "audio/vnd.dts" = "mpv.desktop";
        "audio/vnd.dts.hd" = "mpv.desktop";
        "audio/x-adpcm" = "mpv.desktop";
        "application/x-cue" = "mpv.desktop";
        "audio/m3u" = "mpv.desktop";
        "audio/vnd.wave" = "mpv.desktop";
        "video/vnd.avi" = "mpv.desktop";

        # https://github.com/transmission/transmission/blob/7e4b4f10a1f90885c0bebb168eedffe153f1cf53/gtk/transmission-gtk.desktop.in#L13
        "application/x-bittorent" = "transmission-gtk.desktop";
        "x-scheme-handler/magnet" = "transmission-gtk.desktop";
      };
    };
  };
}
