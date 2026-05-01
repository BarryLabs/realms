{config, ...}: {
  flake.nixosModules.hyprland = {pkgs, ...}: {
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
    ];
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
