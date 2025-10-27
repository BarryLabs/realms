{ config
, lib
, ...
}:
with lib; let
  module = "sops";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Sops Module";
  config = mkIf cfg.enable {
    sops = {
      age = {
        keyFile = config.var.ageFile;
      };
      defaultSopsFormat = lib.mkDefault "yaml";
      defaultSopsFile = lib.mkDefault ../../../secrets/${config.var.host}.yaml;
    };
  };
}
