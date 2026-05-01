{
  flake.nixosModules.nushell = {pkgs, ...}: {
    environment.systemPackages = [pkgs.unixtools.netstat pkgs.nushell];
  };
  flake.homeModules.nushell = {pkgs, ...}: {
    home.packages = with pkgs; [
      unixtools.netstat
      nushell
    ];
  };
}
