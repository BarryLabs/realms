{ config
, lib
, ...
}:
with lib; let
  module = "gnupg";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base GnuPG Module";
  config = mkIf cfg.enable {
    programs = {
      gnupg = {
        agent = {
          enable = true;
          enableSSHSupport = true;
        };
      };
    };
  };
}
