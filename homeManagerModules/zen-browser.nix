{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  options = {
    zen-browser.enable = lib.mkEnableOption "enable zen-browser";
  };

  config = lib.mkIf config.zen-browser.enable {
    programs.zen-browser = {
      enable = true;
      darwinDefaultsId = "app.zen-browser.zen";
      policies = {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };
      profiles.default = let
        spaces = {
          "Main" = {
            id = "5CD81D04-1BB2-4F95-A968-C29F44CBBEED";
            position = 1000;
            theme = {
              type = "gradient";
              colors = [
                {
                  red = 121;
                  green = 183;
                  blue = 236;
                  algorithm = "complementary";
                  lightness = 70;
                  position.x = 138;
                  position.y = 158;
                  type = "explicit-lightness";
                }
                {
                  red = 237;
                  green = 172;
                  blue = 120;
                  algorithm = "complementary";
                  lightness = 70;
                  position.x = 220;
                  position.y = 200;
                  type = "explicit-lightness";
                }
              ];
              opacity = 0.75;
              texture = 0.5;
            };
          };
        };
        pins = {
          "T3 Chat" = {
            id = "7C56D7DC-0F8C-4BE2-A17C-52C3068179DA";
            url = "https://t3.chat";
            isEssential = true;
            position = 104;
          };
          "Overleaf" = {
            id = "BB168C79-0B6B-4896-BED1-93BEAA88154D";
            url = "https://overleaf.com";
            isEssential = true;
            position = 103;
          };
          "GitHub" = {
            id = "A5D60D92-072A-4088-8E8E-AD5BB53BDD43";
            url = "https://github.com";
            isEssential = true;
            position = 102;
          };
          "Easyword" = {
            id = "C547D1EF-EC82-4DED-9004-82F5089854C8";
            url = "https://easyword.kr";
            isEssential = true;
            position = 101;
          };
        };
      in {
        inherit spaces pins;
        settings = {
          # Refer to about:config
          "zen.tabs.vertical.right-side" = true;
          "zen.workspaces.continue-where-left-off" = true;
        };
      };
    };
  };
}

