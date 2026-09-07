{self, ...}: {
  flake.nixosModules.pandora = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.pandora];
  };

  flake.homeModules.pandora = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.pandora];
  };

  perSystem = {pkgs, ...}: {
    packages.pandora = pkgs.rustPlatform.buildRustPackage rec {
      pname = "pandora";
      version = "0.5.2";

      src = pkgs.fetchFromGitHub {
        owner = "BarryLabs";
        repo = "pandora";
        rev = "v${version}";
        hash = "sha256-qN4u6XIxIHsTdXHkteD0cEB5lGCECWtyclMSE8yfVu0=";
      };

      cargoHash = "sha256-wlCdG/qj3cgf4qWrGtvnMNnmaXHc/xrYjsAJhMREPbI=";

      nativeBuildInputs = with pkgs; [
        pkg-config
      ];

      meta = with pkgs.lib; {
        description = "A CLI/TUI Game Emulator Save-State Manager.";
        homepage = "https://github.com/BarryLabs/pandora";
        license = licenses.agpl3Plus;
        maintainers = ["BarryLabs"];
        mainProgram = "pandora";
      };
    };
  };
}
