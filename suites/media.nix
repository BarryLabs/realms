{
  flake.nixosModules.suitesMedia = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      mpv
      zathura
    ];
  };
}
