{ pkgs ? import <nixpkgs> { }
,
}:
pkgs.mkShell {
  RUST_BACKTRACE = "full";
  buildInputs = with pkgs; [
    cargo
    clippy
    rustc
    rustfmt
    pkg-config
    openssl
  ];
}
