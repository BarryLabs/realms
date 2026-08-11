{
  flake.nixosModules.suitesComm = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      goofcord
      gajim
    ];
  };
}
