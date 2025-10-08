{ pkgs ? import <nixpkgs> { }
,
}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    jujutsu
    helix
    sops
    yazi
  ];
}
