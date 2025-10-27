{ config
, lib
, ...
}:
with lib;
let
  module = "nix-ld";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Dynamic Library Module";
  config = mkIf cfg.enable {
    programs.nix-ld = {
      enable = true;
    };
  };
}
