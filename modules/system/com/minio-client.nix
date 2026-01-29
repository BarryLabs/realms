{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "minio-client";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Minio-Client Module";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      minio-client
    ];
  };
}
