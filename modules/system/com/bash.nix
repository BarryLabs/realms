{ config
, lib
, ...
}:
with lib;
let
  module = "bash";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Bash Module";
  config = mkIf cfg.enable {
    programs.${module} = {
      completion = {
        enable = true;
      };
      shellAliases = lib.mkDefault {
        h = "history";
      };
    };
  };
}
