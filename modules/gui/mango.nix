{config, ...}: {
  flake.nixosModules.mango = {pkgs, ...}: {
    services.greetd = {
      enable = true;
      settings = rec {
        default_session = initial_session;
        initial_session = {
          user = config.var.user;
          command = "${pkgs.mangowc}/bin/mango";
        };
      };
    };
    environment.systemPackages = with pkgs; [
      wl-clipboard
      grim
      slurp
      swappy
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
