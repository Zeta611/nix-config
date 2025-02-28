{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  options = {
    claude-code.enable = lib.mkEnableOption "enable claude-code";
  };

  config = lib.mkIf config.claude-code.enable {
    home.packages = with pkgs; [
      claude-code
    ];
  };
}
