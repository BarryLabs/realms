{
  stdenv,
  lib,
  makeWrapper,
  nushell,
  fd,
  fzf,
  zellij,
}:
stdenv.mkDerivation {
  pname = "zellij-ps";
  version = "0.1.0";
  src = builtins.path [ ./zellij-ps.nu ];
  buildInputs = [ ];
  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp zellij-ps.nu $out/bin/zellij-ps
    wrapProgram $out/bin/zellij-ps \
      --prefix PATH : ${
        lib.makeBinPath [
          nushell
          fd
          fzf
          zellij
        ]
      }
  '';
  meta = with lib; {
    description = "Zellij-PS from m3tam3re for nushell.";
    homepage = "https://code.m3tam3re.com/m3tam3re/helper-scripts";
    license = licenses.mit;
    maintainers = with maintainers; [ BarryLabs ];
    platforms = platforms.unix;
  };
}
