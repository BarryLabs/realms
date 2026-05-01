{
  flake.nixosModules.content = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      ardour
      blender
      libreoffice
      gimp
      obs-studio
    ];
  };
}
