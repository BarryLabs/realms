{self, ...}: {
  flake.nixosModules.ollama = {pkgs, ...}: {
    services = {
      open-webui = {
        enable = true;
        host = "127.0.0.1";
      };
      ollama = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.ollama;
        acceleration = "cuda";
        loadModels = [
          "llama3.2:3b"
          "qwen3:14b"
          "nomic-embed-text"
        ];
      };
    };
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.ollama];
  };

  flake.homeModules.ollama = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.ollama];
  };

  perSystem = {pkgs, ...}: {
    packages.ollama = pkgs.ollama;
  };
}
