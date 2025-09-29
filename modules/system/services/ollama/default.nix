{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.services.ollama;
in
{
  options.augs.services.ollama.enable = mkEnableOption "Base Ollama Module";
  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;
      acceleration = "cuda";
      loadModels = [
        "llama3.2:3b"
        "phi4-reasoning:14b"
        "dolphin3:8b"
        "smallthinker:3b"
        "deepcoder:14b"
        "qwen3:14b"
        "nomic-embed-text"
      ];
    };
  };
}
