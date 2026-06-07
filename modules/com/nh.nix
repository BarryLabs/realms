{
  flake.nixosModules.nh = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      nix-output-monitor
      nvd
    ];
    programs.nh = {
      enable = true;
      flake = "/etc/nixos";
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 5";
      };
    };
  };
}
