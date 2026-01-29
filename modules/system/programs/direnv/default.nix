{ config
, lib
, ...
}:
with lib; let
  module = "direnv";
  cfg = config.augs.programs.${module};
in
{
  options.augs.programs.${module}.enable = mkEnableOption "DirEnv Module";
  config = mkIf cfg.enable {
    programs = {
      ${module} = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
