{config, ...}: {
  flake.nixosModules.zsh = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      bat
      dust
      eza
      fzf
      git
      ripgrep
      starship
      zoxide
    ];
    programs.zsh = {
      enable = true;
      autosuggestions = {
        enable = true;
        async = true;
        strategy = [
          "history"
          "completion"
        ];
      };
      shellAliases = {
        ls = "${pkgs.eza}/bin/eza --icons --group-directories-first";
        ll = "ls -l";
        la = "ls -la";
        cat = "${pkgs.bat}/bin/bat";
        cp = "cp -i";
        mv = "mv -i";
        rm = "rm -i";
        gst = "git status";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gl = "git pull";
      };
    
      # interactiveShellInit = ''
      #   # Environment
      #   export EDITOR="hx"
      #   export VISUAL="hx"
      #   export TERMINAL="ghostty"
      
      #   # History
      #   HISTFILE="$HOME/.zsh_history"
      #   HISTSIZE=20000
      #   SAVEHIST=20000
      
      #   setopt EXTENDED_HISTORY
      #   setopt SHARE_HISTORY
      #   setopt HIST_IGNORE_SPACE
      #   setopt HIST_IGNORE_ALL_DUPS
      #   setopt APPEND_HISTORY
      #   setopt AUTOCD    
      
      #   ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#663399,standout"
      #   ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
      #   ZSH_AUTOSUGGEST_USE_ASYNC=1
      #   ZSH_AUTOSUGGEST_STRATEGY=(history completion)
     
      #   starship init zsh
      #   zoxide init zsh
      
      #   if command -v devenv >/dev/null 2>&1; then
      #     devenv hook zsh
      #   fi   
      # '';
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
            else if config.programs.emacs.enable
            then "emacs"
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
