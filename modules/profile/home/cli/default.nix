{ config
, lib
, ...
}:
with lib;
let
  module = "cli";
  cfg = config.mods.profile.${module};
in
{
  imports = [
    ../../../home
  ];
  options.mods.profile.${module}.enable = mkEnableOption "Base CLI Profile";
  config = mkIf cfg.enable {
    mods = {
      terminal = {
        foot.enable = true;
        wezterm.enable = true;
      };
      cli = {
        bat.enable = true;
        eza.enable = true;
        fastfetch.enable = true;
        fzf.enable = true;
        git.enable = true;
        helix.enable = true;
        jujutsu.enable = true;
        starship.enable = true;
        yazi.enable = true;
        yt-dlp.enable = true;
        zellij.enable = true;
        zsh.enable = true;
      };
      tools = {
        btop.enable = true;
        podman.enable = true;
      };
    };
  };
}
