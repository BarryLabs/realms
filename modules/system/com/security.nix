{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.com.security;
in
{
  options.augs.com.security.enable = mkEnableOption "Base Security Module";
  config = mkIf cfg.enable {
    security = {
      virtualisation = {
        flushL1DataCache = "always";
      };
      forcePageTableIsolation = true;
      lockKernelModules = true;
      protectKernelImage = true;
      unprivilegedUsernsClone = config.virtualisation.containers.enable;
    };
  };
}
