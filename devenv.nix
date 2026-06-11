{
  pkgs,
  config,
  ...
}: {
  env = {
    PROJECT = "Realms";
    VERSION = "0.4.1";
    PATCH = "Can we call it cleaning? | Cachy Kernel | Zen Module | Fish Annoys Me | Hyprland is Best";
  };

  packages = [
    pkgs.alejandra # Nix Formatter
    pkgs.git # Version Control
    pkgs.jujutsu # Better Version Control
    pkgs.nixd # Nix LSP
  ];

  difftastic.enable = true;

  languages.nix.enable = true;

  enterShell = ''
    echo "Version Check:"
    echo "-------------------"
    echo " "
    alejandra --version
    git --version
    jj --version
    nixd --version
  '';

  tasks."realms:upload" = {
    exec = ''
      alejandra .
      jj bookmark set main
      jj commit -m "${toString config.env.PROJECT} | ${toString config.env.VERSION} | ${toString config.env.PATCH}"
      jj git push
    '';
  };
}
