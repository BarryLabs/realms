{ config
, lib
, ...
}:
with lib; let
  module = "emacs";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Base Emacs Module";
  config = mkIf cfg.enable {
    programs = {
      ${module} = {
        enable = true;
        extraConfig = ''
          (setq standard-indent 2)
        '';
        extraPackages = epkgs: [
          epkgs.emms
          epkgs.magit
        ];
      };
    };
  };
}
