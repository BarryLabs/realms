{config, ...}: {
  flake.nixosModules.zsh = {
    programs.zsh = {
      enable = true;
    };
  };
  flake.homeModules.zsh = {lib, ...}: {
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
        sessionVariables = {
          EDITOR =
            if config.programs.helix.enable
            then "hx"
            else if config.programs.nvim.enable
            then "nvim"
            else "nano";
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
        initContent = lib.mkOrder 1200 ''
          eval "$(starship init zsh)"
        '';
      };
    };
  };
}
