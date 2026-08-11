{
  flake.nixosModules.protonvpn = {pkgs, ...}: {
    networking.firewall.checkReversePath = false;
    environment.systemPackages = with pkgs; [
      wireguard-tools
      proton-vpn
    ];
  };
}
