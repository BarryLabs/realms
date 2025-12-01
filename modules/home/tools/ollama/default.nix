{ config
, lib
, ...
}:
with lib;
let
  module = "ollama";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Ollama Module for Nvidia GPU's";
  config = mkIf cfg.enable {
    # home.persistence."/nix/persist/home" = {
    #   directories = [
    #     ".ollama"
    #   ];
    # };
    services = {
      ${module} = {
        enable = true;
        # acceleration = "cuda";
      };
    };
  };
}
