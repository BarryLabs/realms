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
        foot.enable = true;
      };
      cli = {
        bat.enable = true;
        eza.enable = true;
        fastfetch.enable = true;
        fzf.enable = true;
        goose-cli.enable = true;
        minio-client.enable = true;
        pandoc.enable = true;
        starship.enable = true;
        stow.enable = true;
        yazi.enable = true;
        yt-dlp.enable = true;
        zellij.enable = true;
        zoxide.enable = true;
        zsh.enable = true;
      };
      tools = {
        btop.enable = true;
        podman.enable = true;
      };
    };
  };
}
