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
      # Toolchains
      rustup
      uv
      zig
      # Language Servers
      marksman
      markdown-oxide
    ];
    mods = {
      cli = {
        direnv.enable = true;
        helix.enable = true;
        jujutsu.enable = true;
      };
    };
  };
}
