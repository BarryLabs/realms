{
  flake.nixosModules.superfile = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [superfile];
  };
}
