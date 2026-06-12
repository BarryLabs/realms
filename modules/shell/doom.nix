{inputs, pkgs, ...}: {
  flake.nixosModules.doom = {
    nixpkgs.overlays = [ 
      inputs.nix-doom-emacs-unstraightened.overlays.default 
    ];

    environment.systemPackages = [
      (pkgs.doomEmacs {
        doomDir = ./doom.d;
        doomLocalDir = "~/.local/share/nix-doom";
      })
    ];
  };
}
