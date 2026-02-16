{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    aerospace.enable = lib.mkEnableOption "enable aerospace";
  };

  config = lib.mkIf config.aerospace.enable {
    programs.aerospace.enable = true;
    xdg.configFile."aerospace/aerospace.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/homeManagerModules/aerospace.toml";
  };
}
