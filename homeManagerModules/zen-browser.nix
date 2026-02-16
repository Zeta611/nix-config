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
      profiles.default.settings = {
        # Refer to about:config
        "zen.tabs.vertical.right-side" = true;
        "zen.workspaces.continue-where-left-off" = true;
      };
    };
  };
}

