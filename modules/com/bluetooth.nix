{
  flake.nixosModules.bluetooth = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      bluetui
    ];
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
