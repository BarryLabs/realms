{
  flake.nixosModules.cyncthing = {pkgs, ...}: {
    systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
    networking.firewall = {
      allowedTCPPorts = [22000];
      allowedUDPPorts = [21027 22000];
    };
    environment.systemPackages = with pkgs; [
      syncthing
    ];
  };
}
