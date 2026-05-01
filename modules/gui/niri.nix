{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.niri = {
    pkgs,
    config,
    ...
  }: {
    imports = [
      self.nixosModules.noctalia
    ];
    services.greetd = {
      enable = true;
      settings = rec {
        default_session = initial_session;
        initial_session = {
          user = config.client.user;
          command =
            if config.programs.niri.enable
            then "${pkgs.niri}/bin/niri-session"
            else "";
        };
      };
    };
    environment.systemPackages = with pkgs; [
      xwayland-satellite
      wl-clipboard
      nautilus
      inputs.matugen.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.Niri;
    };
  };

  perSystem = {pkgs, ...}: {
    packages.Niri = pkgs.niri;
  };
}
