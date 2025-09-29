{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.programs.firejail;
in
{
  options.augs.programs.firejail.enable = mkEnableOption "Base Firejail Module";
  config = mkIf cfg.enable {
    programs = {
      firejail = {
        enable = true;
        wrappedBinaries = {
          firefox = {
            executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
            profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
          };
          qutebrowser = {
            executable = "${pkgs.lib.getBin pkgs.qutebrowser}/bin/qutebrowser";
            profile = "${pkgs.firejail}/etc/firejail/qutebrowser.profile";
          };
          mpv = {
            executable = "${pkgs.lib.getBin pkgs.mpv}/bin/mpv";
            profile = "${pkgs.firejail}/etc/firejail/mpv.profile";
          };
          zathura = {
            executable = "${pkgs.lib.getBin pkgs.zathura}/bin/zathura";
            profile = "${pkgs.firejail}/etc/firejail/zathura.profile";
          };
          vesktop = {
            executable = "${pkgs.lib.getBin pkgs.vesktop}/bin/vesktop";
            profile = "${pkgs.vesktop}/etc/firejail/vesktop.profile";
          };
        };
      };
    };
  };
}
