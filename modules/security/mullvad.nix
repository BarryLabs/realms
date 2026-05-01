{
  flake.nixosModules.mullvad = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      mullvad-compass
      mullvad-browser
    ];
    services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad;
    };
  };
}
