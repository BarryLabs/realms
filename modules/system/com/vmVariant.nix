{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.com.vmVariant;
in
{
  options.augs.com.vmVariant.enable = mkEnableOption "Base vmVariant Module";
  config = mkIf cfg.enable {
    virtualisation = {
      vmVariant = {
        virtualisation = {
          useBootLoader = lib.mkDefault false;
          useEFIBoot = lib.mkDefault false;
          cores = lib.mkDefault 1;
          memorySize = lib.mkDefault 1024;
          graphics = lib.mkDefault false;
          diskSize = lib.mkDefault 32768;
        };
      };
    };
  };
}
