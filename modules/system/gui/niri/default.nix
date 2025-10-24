{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "niri";
  cfg = config.augs.gui.${module};
in
{
  options.augs.gui.${module}.enable = mkEnableOption "Base Niri Module";
  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = rec {
        default_session = initial_session;
        initial_session = {
          user = config.var.user;
          command = if config.augs.gui.niri.enable then "${pkgs.niri}/bin/niri-session" else "";
        };
      };
    };
    systemd.user.tmpfiles.users.${config.var.user}.rules = lib.optional config.programs.niri.enable
      "L %h/.config/niri/config.kdl - - - - /etc/nixos/modules/system/gui/niri/niri.kdl";
    environment = lib.mkIf config.augs.gui.${module}.enable {
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
        WAYLAND_DISPLAY = "wayland-1";
        WLR_NO_HARDWARE_CURSORS = "1";
      };
      systemPackages = with pkgs; [
        xwayland-satellite
        hyprpicker
        mpvpaper
        wl-clipboard
      ];
    };
    programs.niri = {
      enable = true;
    };
  };
}
