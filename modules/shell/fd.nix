{
  flake.nixosModules.fd = {pkgs, ...}: {
    environment.systemPackages = [pkgs.fd];
  };
  flake.homeModules.fd = {pkgs, ...}: {
    home.packages = with pkgs; [
      fd
    ];
  };
}
