{ self, ... }: {
  flake.nixosModules.syncthing = { pkgs, ... }: {
    systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
    networking.firewall = {
      allowedTCPPorts = [ 22000 ];
      allowedUDPPorts = [ 21027 22000 ];
    };
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.syncthing ];
  };

  perSystem = { pkgs, ... }: {
    packages.syncthing = pkgs.syncthing;
  };
}
