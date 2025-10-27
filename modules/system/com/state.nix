{ config
, lib
, ...
}:
with lib; let
  module = "state";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.state.enable = mkEnableOption "Base Compatibility State Module";
  config = mkIf cfg.enable {
    system = {
      stateVersion = lib.mkDefault config.var.state;
    };
  };
}
