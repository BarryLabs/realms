{ config
, lib
, ...
}:
with lib;
let
  module = "nfs-client";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Client NFS Module";
  config = mkIf cfg.enable { };
}
