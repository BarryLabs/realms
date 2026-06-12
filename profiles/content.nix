{
  flake.nixosModules.content = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      blender
      gimp-with-plugins
      libreoffice-fresh
      obs-studio
    ];
  };
}
