{
  flake.nixosModules.nh = {pkgs, ...}: {
    programs.nh = {
      enable = true;
      flake = "/etc/nixos";
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 5";
      };
    };

    environment.systemPackages = with pkgs; [
      nix-output-monitor
      nvd
    ];
  };
}
