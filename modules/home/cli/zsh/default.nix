{ config
, lib
, ...
}:
with lib;
let
  module = "zsh";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Base Zsh Module";
  config = mkIf cfg.enable {
    programs = {
      ${module} = {
        enable = true;
        autocd = true;
        enableCompletion = true;
        autosuggestion = {
          enable = true;
        };
        history = {
          path = "$HOME/.zsh_history";
          append = true;
          extended = true;
          size = 2000;
          ignoreSpace = true;
          ignoreAllDups = true;
          ignorePatterns = [
            "rm *"
            "pkill *"
            "cp *"
            "l*"
          ];
        };
        sessionVariables = {
          EDITOR = if config.mods.cli.helix.enable then "hx" else "nano";
          NIX_LOG = "info";
          NIX_PATH = "nixpkgs=channel:nixos-unstable";
        };
        shellAliases = {
          ll = "ls -l";
          la = "ls -laF";
          cat = "bat";
          cp = "cp -i";
          mv = "mv -i";
          rm = "rm -i";
          nc = "nix-collect-garbage -d";
        };
        syntaxHighlighting = {
          enable = true;
        };
      };
    };
  };
}
