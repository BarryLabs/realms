{self, ...}: {
  flake.nixosModules.operand = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.operand];
  };
  flake.homeModules.operand = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.operand];
  };

  perSystem = {pkgs, ...}: {
    packages.operand = pkgs.stdenv.mkDerivation {
      pname = "operand";
      version = "0.1.0";

      src = pkgs.fetchFromGitea {
        domain = "codeberg.org";
        owner = "BarryLabs";
        repo = "operand";
        rev = "v0.1.0";
        sha256 = pkgs.lib.fakeSha256;
      };

      nativeBuildInputs = with pkgs; [
        zig
      ];

      buildInputs = with pkgs; [
        raylib
        libGL
        xorg.libX11
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXrandr
      ];

      buildPhase = ''
        export HOME=$TMPDIR
        zig build -Doptimize=ReleaseSmall
      '';

      installPhase = ''
        install -Dm755 zig-out/bin/operand $out/bin/operand
      '';
    };
  };
}
