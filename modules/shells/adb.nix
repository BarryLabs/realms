{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    androidenv.androidPkgs_9_0.platform-tools
  ];
}
