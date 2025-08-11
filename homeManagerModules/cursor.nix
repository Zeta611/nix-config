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

  config = lib.mkIf config.claude-code.enable {
    home.packages = with pkgs; [
      code-cursor
    ];
  };
}
