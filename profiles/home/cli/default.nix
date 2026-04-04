{
  config,
  lib,
  ...
}:
with lib;
let
  module = "cli";
  cfg = config.mods.profile.${module};
in
{
  imports = [
    ../../../modules/home
  ];
  options.mods.profile.${module}.enable = mkEnableOption "CLI Profile";
  config = mkIf cfg.enable {
    mods = {
      terminal = {
        ghostty.enable = true;
        wezterm.enable = true;
      };
      cli = {
        bat.enable = true;
        eza.enable = true;
        dust.enable = true;
        fastfetch.enable = true;
        minio-client.enable = true;
        starship.enable = true;
        stow.enable = true;
        yazi.enable = true;
        zellij.enable = true;
        zoxide.enable = true;
        zsh.enable = true;
      };
      tools = {
        btop.enable = true;
        podman.enable = true;
        matugen.enable = true;
      };
    };
  };
}
