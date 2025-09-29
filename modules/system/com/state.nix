{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.com.state;
in
{
  options.augs.com.state.enable = mkEnableOption "Base Compatibility State Module";
  config = mkIf cfg.enable {
    system = {
      stateVersion = lib.mkDefault config.var.state;
    };
  };
}
