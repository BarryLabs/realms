{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.programs.localsend;
in
{
  options.augs.programs.localsend.enable = mkEnableOption "Base Localsend Module";
  config = mkIf cfg.enable {
    programs = {
      localsend = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
