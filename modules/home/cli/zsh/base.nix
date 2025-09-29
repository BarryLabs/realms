{ config
, lib
, ...
}:
with lib;
let
  cfg = config.mods.cli.zsh.base;
in
{
  options.mods.cli.zsh.base.enable = mkEnableOption "Base Zsh Module";
  config = mkIf cfg.enable {
    programs = {
      zsh = {
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
        syntaxHighlighting = {
          enable = true;
        };
        shellAliases = {
          ll = "ls -l";
          la = "ls -laF";
          cat = "bat";
          cp = "cp -i";
          mv = "mv -i";
          rm = "rm -i";
          nixclean = "doas nix-collect-garbage -d";
          clean = "nix-collect-garbage -d";
        };
        initContent = ''
          export EDITOR="hx"
          export NIX_LOG info
          export NIX_PATH nixpkgs=channel:nixos-unstable
          export FZF_DEFAULT_OPTS=" \
          --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
          --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
          --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
          --color=selected-bg:#45475a \
          --multi"
        '';
      };
    };
  };
}
