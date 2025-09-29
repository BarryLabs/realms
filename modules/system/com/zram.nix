{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.com.zram;
in
{
  options.augs.com.zram.enable = mkEnableOption "Base ZRAM Module";
  config = mkIf cfg.enable {
    zramSwap = {
      enable = true;
      algorithm = lib.mkDefault "zstd";
    };
  };
}
