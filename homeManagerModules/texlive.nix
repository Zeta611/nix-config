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

  config = let
    ebproofx = pkgs.stdenvNoCC.mkDerivation {
      name = "ebproofx";
      src = ./texmf;
      installPhase = "cp -r $src $out";
      passthru.tlType = "run";
    };
    latex-report-classes = pkgs.stdenvNoCC.mkDerivation {
      name = "latex-report-classes";
      src = ./texmf;
      installPhase = "cp -r $src $out";
      passthru.tlType = "run";
    };
    simplesnt = pkgs.stdenvNoCC.mkDerivation {
      name = "simplesnt";
      src = ./texmf;
      installPhase = "cp -r $src $out";
      passthru.tlType = "run";
    };
    snu-ece-bsc-thesis = pkgs.stdenvNoCC.mkDerivation {
      name = "snu-ece-bsc-thesis";
      src = ./texmf;
      installPhase = "cp -r $src $out";
      passthru.tlType = "run";
    };
    zdoc = pkgs.stdenvNoCC.mkDerivation {
      name = "zdoc";
      src = ./texmf;
      installPhase = "cp -r $src $out";
      passthru.tlType = "run";
    };
    custom-texmf = {
      pkgs = [ ebproofx latex-report-classes simplesnt snu-ece-bsc-thesis zdoc ];
    };
  in
  lib.mkIf config.texlive.enable {
    programs.texlive = {
      enable = true;
      extraPackages = tpkgs: {
        inherit (tpkgs) scheme-full;
        inherit custom-texmf;
        pkgFilter = pkg: pkg.tlType == "run" || pkg.tlType == "bin" || pkg.tlType == "doc" || pkg.tlType == "source";
      };
    };
  };
}
