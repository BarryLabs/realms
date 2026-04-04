{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  module = "matugen";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Matugen Module";
  config = mkIf cfg.enable {
    imports = [
      inputs.matugen.nixosModules.default
    ];
  };
}
