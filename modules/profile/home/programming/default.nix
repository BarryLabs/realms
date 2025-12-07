{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "programming";
  cfg = config.mods.profile.${module};
in
{
  imports = [
    ../../../home
  ];
  options.mods.profile.${module}.enable = mkEnableOption "Programming Profile";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      uv
      zig
      rustup
    ];
  };
}
