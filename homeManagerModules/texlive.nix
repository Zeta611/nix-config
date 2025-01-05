{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    texlive.enable = lib.mkEnableOption "enable texlive";
  };

  config = lib.mkIf config.texlive.enable {
    programs.texlive = {
      enable = true;
      extraPackages = tpkgs: {
        inherit (tpkgs) scheme-full;
      };
    };
  };
}
