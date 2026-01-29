{
  config,
  lib,
  ...
}:
with lib;
let
  module = "bcachefs";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "bcachefs Module";
  config = mkIf cfg.enable {
    boot.supportedFilesystems = [ "bcachefs" ];
  };
}
