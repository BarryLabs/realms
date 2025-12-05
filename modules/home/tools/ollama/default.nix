{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "ollama";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Ollama Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ollama
    ];
  };
}
