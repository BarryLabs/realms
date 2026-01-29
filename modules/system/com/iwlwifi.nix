{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "iwlwifi";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "iwlwifi Module";
  config = mkIf cfg.enable { };
}
