{
  flake.nixosModules.suitesContent = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      blender
      gimp-with-plugins
      libreoffice-stable
      obs-studio
    ];
  };
}
