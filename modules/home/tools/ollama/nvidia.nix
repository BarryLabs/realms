{ config
, lib
, ...
}:
with lib;
let
  cfg = config.mods.tools.ollama.nvidia;
in
{
  options.mods.tools.ollama.nvidia.enable = mkEnableOption "Ollama Module for Nvidia GPU's";
  config = mkIf cfg.enable {
    services = {
      ollama = {
        enable = true;
        acceleration = "cuda";
      };
    };
  };
}
