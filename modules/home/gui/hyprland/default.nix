{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "hyprland";
  cfg = config.mods.gui.${module};
in
{
  options.mods.gui.${module}.enable = mkEnableOption "Hyprland Module";
  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        (pkgs.writeShellScriptBin "screenshot" ''
          grim -g "$(slurp)" - | swappy -f -
        '')
        hyprland
        hypridle
        hyprpicker
        hyprsunset
        cliphist
        wl-clipboard
        grim
        slurp
        swappy
      ];
    };
  };
}
