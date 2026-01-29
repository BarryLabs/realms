{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "programming";
  cfg = config.mods.profile.${module};
in
{
  imports = [
    ../../../modules/home
  ];
  options.mods.profile.${module}.enable = mkEnableOption "Programming Profile";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      go
      uv
      zig
      rustup
    ];
    mods = {
      cli = {
        helix.enable = true;
        jujutsu.enable = true;
      };
      tools = {
        zed.enable = true;
      };
    };
  };
}
