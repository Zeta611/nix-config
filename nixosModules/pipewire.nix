{ pkgs, lib, config, ... }:

{
  options = {
    pipewire.enable = lib.mkEnableOption "enable pipewire";
  };

  config = lib.mkIf config.pipewire.enable {
    environment.systemPackages = with pkgs; [
      pavucontrol
    ];

    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
