{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.zellij-ps;
in
{
  options = {
    programs.zellij-ps = {
      enable = mkEnableOption "Zellij Project Selector";
      projectFolders = lib.mkOption {
        type = lib.types.listOf lib.types.path;
        description = "List of project folders for zellij-ps.";
        default = [ "${config.home.homeDirectory}/Projects" ];
      };
      layout = lib.mkOption {
        type = lib.types.str;
        description = "Layout for zellij";
        default = ''
          layout {
              pane size=1 borderless=true {
                  plugin location="zellij:tab-bar"
              }
              pane
              pane split_direction="vertical" {
                  pane
                  pane command="htop"
              }
              pane size=2 borderless=true {
                  plugin location="zellij:status-bar"
              }
          }
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = [ pkgs.zellij-ps ];
    home.sessionVariables.PROJECT_FOLDERS = lib.concatStringsSep ":" cfg.projectFolders;
    home.file.".config/zellij/layouts/zellij-ps.kdl".text = cfg.layout;
  };
}
