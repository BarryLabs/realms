{
  flake.nixosModules.kicad = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.kicad
    ];
  };
}
