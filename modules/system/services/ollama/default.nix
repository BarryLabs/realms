{ config
, lib
, ...
}:
with lib;
let
  module = "ollama";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Ollama Module";
  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;
      acceleration = "cuda";
      loadModels = [
        "llama3.2:3b"
        "qwen3:14b"
        "nomic-embed-text"
      ];
    };
  };
}
