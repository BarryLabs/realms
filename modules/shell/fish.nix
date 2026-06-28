{
  flake.nixosModules.fish = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        zoxide init fish | source
        starship init fish | source
        devenv init fish | source
      '';
    };
  };
}
