{ config
, lib
, ...
}:
with lib;
let
  module = "ghidra";
  cfg = config.augs.programs.${module};
in
{
  options.augs.programs.${module}.enable = mkEnableOption "Base Ghidra Module";
  config = mkIf cfg.enable {
    environment.sessionVariables =
      if config.programs.niri.enable then {
        _JAVA_AWT_WM_NONREPARENTING = "1";
      } else { };
    programs = {
      ghidra = {
        enable = true;
      };
    };
  };
}
