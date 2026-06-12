{
  flake.nixosModules.nh = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      nix-output-monitor
      nvd
    ];
    programs.nh = {
      enable = true;
      flake = "/home/chandler/Projects/nix/realms";
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 5";
      };
    };
  };
}
