{
  flake.nixosModules.emacs = {
    nixpkgs.overlays = [
      (import (fetchTarball {
        url = "https://github.com/nix-community/emacs-overlay/archive/87181272bf633bbc9f19a8aa8662833940bf18ed.tar.gz";
      }))
    ];
  };
}
