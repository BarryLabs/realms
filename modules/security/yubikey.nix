{config, ...}: {
  flake.nixosModules.yubikey = {
    pkgs,
    lib,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      pam_u2f
      yubikey-manager
      yubioath-flutter
    ];
    services.udev.packages = [pkgs.yubikey-personalization];
    services.pcscd.enable = true;
    services.yubikey-agent.enable = true;
    security = {
      pam = {
        sshAgentAuth.enable = true;
        u2f = {
          enable = true;
          control = "sufficient";
          settings = {
            cue = true;
            debug = false;
            authFile = "${config.client.user}/.config/Yubico/u2f_keys";
          };
        };
        services = {
          login = {
            u2fAuth = true;
            unixAuth = true;
          };
          doas = lib.optionalAttrs (config.security.doas.enable or false) {
            u2fAuth = true;
            unixAuth = true;
            sshAgentAuth = true;
          };
          sudo-rs = lib.optionalAttrs (config.security.sudo-rs.enable or false) {
            u2fAuth = true;
            unixAuth = true;
            sshAgentAuth = true;
          };
        };
      };
    };
  };
}
