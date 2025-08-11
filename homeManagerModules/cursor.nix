{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  options = {
    cursor.enable = lib.mkEnableOption "enable cursor";
  };

  config = lib.mkIf config.cursor.enable {
    home.packages = with pkgs; [
      code-cursor
    ];
  };
}
