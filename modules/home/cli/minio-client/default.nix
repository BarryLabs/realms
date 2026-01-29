{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "minio-client";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Minio-Client Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      minio-client
    ];
  };
}
