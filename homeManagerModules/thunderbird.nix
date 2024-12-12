{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    thunderbird.enable = lib.mkEnableOption "enable thunderbird";
  };

  config = lib.mkIf config.thunderbird.enable {
    programs.thunderbird = {
      enable = true;
      profiles = {
        "Jay Lee" = {
          isDefault = true;
        };
      };
    };
  };
}
