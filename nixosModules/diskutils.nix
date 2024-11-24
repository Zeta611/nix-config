{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    diskutils.enable = lib.mkEnableOption "enable diskutils";
  };

  config = lib.mkIf config.diskutils.enable {
    services.udisks2.enable = true;
    services.gvfs.enable = true;

    environment.systemPackages = with pkgs; [
      exfatprogs
    ];
  };
}
