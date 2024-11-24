{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    unison.enable = lib.mkEnableOption "enable unison";
  };

  config =
    let
      stateDirectory = "${config.home.homeDirectory}/.unison";
    in
    lib.mkIf config.unison.enable {
      services.unison = {
        enable = true;
        pairs = {
          main = {
            roots = [
              "/home/jay"
              "/mnt/jay-main"
            ];
            commandOptions.source = "main.prf";
            stateDirectory = stateDirectory;
          };
          backup = {
            roots = [
              "/home/jay"
              "/mnt/jay-bk"
            ];
            commandOptions.source = "backup.prf";
            stateDirectory = stateDirectory;
          };
        };
      };

      home.packages = with pkgs; [
        unison
      ];
      home.file = {
        ".unison/main.prf".text = builtins.readFile ./unison_default.prf;
        ".unison/backup.prf".text = builtins.readFile ./unison_default.prf;
      };
    };
}
