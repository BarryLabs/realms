{ config
, lib
, ...
}:
with lib;
let
  module = "zram";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base ZRAM Module";
  config = mkIf cfg.enable {
    zramSwap = {
      enable = true;
      algorithm = lib.mkDefault "zstd";
    };
  };
}
