{
  flake.nixosModules.ollama = {
    services = {
      open-webui = {
        enable = true;
        host = "127.0.0.1";
      };
      ollama = {
        enable = true;
        acceleration = "cuda";
        loadModels = [
          "llama3.2:3b"
          "qwen3:14b"
          "nomic-embed-text"
        ];
      };
    };
  };
  flake.homeModules.ollama = {pkgs, ...}: {
    home.packages = with pkgs; [
      ollama
    ];
  };
}
