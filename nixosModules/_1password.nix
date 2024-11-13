{
  lib,
  config,
  ...
}:

{
  options = {
    _1password.enable = lib.mkEnableOption "enable 1password";
  };

  config = lib.mkIf config._1password.enable {
    programs = {
      _1password.enable = true;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = [ "jay" ];
      };
    };
  };
}
