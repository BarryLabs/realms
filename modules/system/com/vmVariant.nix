{ config
, lib
, ...
}:
with lib; let
  module = "vmVariant";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base vmVariant Module";
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
