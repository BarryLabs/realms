{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.hyprland = {pkgs, ...}: {
    imports = [
      self.nixosModules.noctalia
    ];
    services.greetd = {
      enable = true;
      settings = rec {
        default_session = initial_session;
        initial_session = {
          user = "chandler";
          command = "${pkgs.hyprland}/bin/start-hyprland";
        };
      };
    };
    environment.systemPackages = with pkgs; [
      wl-clipboard
      grim
      slurp
      swappy
      nautilus
      inputs.matugen.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };
}
