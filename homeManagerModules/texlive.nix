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

  config =
    let
      custom-texmf = pkgs.stdenvNoCC.mkDerivation {
        pname = "custom-texmf";
        version = "1";
        src = ./texmf;
        outputs = [ "tex" ];
        preHook = ''out="''${tex-}"'';
        installPhase = "cp -r $src $tex";
      };
      texlive =
        (pkgs.texliveFull.overrideAttrs {
          withDocs = true;
        }).withPackages
          (_: [ custom-texmf ]);
    in
    lib.mkIf config.texlive.enable {
      home.packages = [
        texlive
        pkgs.python313Packages.pygments
      ];
    };
}
