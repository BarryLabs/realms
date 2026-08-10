{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.mango = {
    pkgs,
    ...
  }: {
    imports = [
      self.nixosModules.dms
    ];
    services.greetd = {
      enable = true;
      settings = rec {
        default_session = initial_session;
        initial_session = {
          user = "chandler";
          command = "${pkgs.mango}/bin/mango";
        };
      };
    };
    xdg.portal.wlr.enable = true;
    environment.systemPackages = with pkgs; [
      wl-clipboard
      grim
      slurp
      swappy
      nautilus
      inputs.matugen.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    programs = {
      mango = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.Mango;
      };
    };
  };
  perSystem = {
    pkgs,
    ...
  }: {
    packages.Mango = pkgs.mango;
  };
}
