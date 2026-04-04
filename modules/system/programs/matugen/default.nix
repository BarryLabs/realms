{ config
, lib
, pkgs
, inputs
, ...
}:
with lib; let
  module = "matugen";
  cfg = config.augs.programs.${module};
in
{
  options.augs.programs.${module}.enable = mkEnableOption "Matugen Module";
  config = mkIf cfg.enable
  let
    system = "x86_64-linux";
  in {
    environment.systemPackages = with pkgs; [
      inputs.matugen.packages.
    ];
  };
}
