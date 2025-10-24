{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.augs.com.yubikey;
in
{
  options.augs.com.yubikey.enable = mkEnableOption "Base Yubikey Module";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pam_u2f
      yubikey-manager
      yubioath-flutter
    ];
    services.udev.packages = [ pkgs.yubikey-personalization ];
    services.pcscd.enable = true;
    services.yubikey-agent.enable = true;
    # programs.ssh.startAgent = true;
    security = {
      pam = {
        sshAgentAuth.enable = true;
        u2f = {
          enable = true;
          control = "sufficient";
          settings = {
            cue = true;
            debug = false;
            authFile = "${config.var.home}/.config/Yubico/u2f_keys";
          };
        };
        services = {
          login = {
            u2fAuth = true;
            unixAuth = false;
          };
          doas =
            if config.augs.com.doas.enable then {
              u2fAuth = true;
              unixAuth = true;
              sshAgentAuth = true;
            } else { };
          sudo-rs =
            if config.augs.com.sudo-rs.enable then {
              u2fAuth = true;
              unixAuth = true;
              sshAgentAuth = true;
            } else { };
          hyprlock = {
            u2fAuth = true;
            unixAuth = true;
          };
        };
      };
    };
  };
}
