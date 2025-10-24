{ config
, lib
, ...
}:
with lib; let
  module = "localsend";
  cfg = config.augs.programs.localsend;
in
{
  options.augs.programs.${module}.enable = mkEnableOption "Base Localsend Module";
  config = mkIf cfg.enable {
    programs = {
      ${module} = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
