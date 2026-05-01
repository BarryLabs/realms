{
  flake.nixosModules.keepassxc = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      keepassxc
    ];
  };
}
