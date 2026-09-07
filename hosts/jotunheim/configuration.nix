{
  self,
  inputs,
  ...
}: {
  flake.nixOnDroidModules.jotunheimConfiguration = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      ### Variables
      ./variables.nix
    ];

    ### User
    user = {
      userName = config.jotunheim.user;
      shell = "${pkgs.zsh}/bin/zsh";
    };

    ### Locale & Time
    time.timeZone = config.jotunheim.timezone;

    ### Networking
    networking.hosts."127.0.0.1" = [config.jotunheim.host];

    environment.sessionVariables = {
      LANG = config.jotunheim.locale;
      LC_ALL = config.jotunheim.locale;
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    ### Android integration
    android-integration = {
      termux-open.enable = true;
      termux-open-url.enable = true;
      termux-setup-storage.enable = true;
      xdg-open.enable = true;
      termux-wake-lock.enable = true;
      termux-wake-unlock.enable = true;
    };

    ### Nix
    nix = {
      registry = {
        nixpkgs.flake = inputs.nixpkgs;
        nix-on-droid.flake = inputs.nix-on-droid;
      };
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
    };

    ### Terminal
    terminal = {
      font = "${pkgs.terminus_font_ttf}/share/fonts/truetype/TerminusTTF.ttf";
      colors = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        cursor = "#f5e0dc";
        color0 = "#45475a";
        color1 = "#f38ba8";
        color2 = "#a6e3a1";
        color3 = "#f9e2af";
        color4 = "#89b4fa";
        color5 = "#cba6f7";
        color6 = "#94e2d5";
        color7 = "#bac2de";
        color8 = "#585b70";
        color9 = "#f38ba8";
        color10 = "#a6e3a1";
        color11 = "#f9e2af";
        color12 = "#89b4fa";
        color13 = "#cba6f7";
        color14 = "#94e2d5";
        color15 = "#a6adc8";
      };
    };

    ### Packages
    environment = {
      etcBackupExtension = ".bak";
      packages = with pkgs; [
        zsh
        git
        openssh
        curl
        wget
        eza
        fd
        bat
        ripgrep
        fzf
        zoxide
        neovim
        starship
        terminus_font_ttf
      ];
    };

    ### State
    system.stateVersion = config.jotunheim.state;
  };
}
