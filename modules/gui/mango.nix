{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.mango = {
    pkgs,
    config,
    ...
  }: {
    services.greetd = {
      enable = true;
      settings = rec {
        default_session = initial_session;
        initial_session = {
          user = config.abyss.user;
          command = "${pkgs.mangowc}/bin/mango";
        };
      };
    };
    imports = [
      self.nixosModules.noctalia
    ];
    environment.systemPackages = with pkgs; [
      wl-clipboard
      grim
      slurp
      swappy
      nautilus
      inputs.matugen.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    programs = {
      mangowc = {
        enable = true;
        # package = self.packages.${pkgs.stdenv.hostPlatform.system}.myMango;
      };
    };
  };
  # perSystem = {
  #   pkgs,
  #   lib,
  #   self',
  #   ...
  # }: {
  #   package.myMango = inputs.wrapper-modules.wrappers.mangowc.wrap {
  #     inherit pkgs;
  #     configFile = {};
  #     extraContent = ''

  #     '';
  #   };
  # };
}
