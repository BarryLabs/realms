{
  flake.nixosModules.talosctl = {pkgs, ...}: {
    environment.systemPackages = [pkgs.talosctl];
  };
}
