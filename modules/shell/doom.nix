{
  flake.nixosModules.doom = {inputs, pkgs, ...}: {
    nixpkgs.overlays = [ 
      inputs.nix-doom-emacs-unstraightened.overlays.default 
    ];

    environment.systemPackages = [
      (pkgs.emacsWithDoom {
        doomDir = ./doom.d;
        doomLocalDir = "~/.local/share/nix-doom";
      })
    ];
  };
}
