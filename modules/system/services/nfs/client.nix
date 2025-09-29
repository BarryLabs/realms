{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.services.nfs.default;
in
{
  options.augs.services.nfs.default.enable = mkEnableOption "Base Client NFS Module";
  config = mkIf cfg.enable { };
}
