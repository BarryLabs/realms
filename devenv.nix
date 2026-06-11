{
  pkgs,
  config,
  ...
}: {
  env = {
    PROJECT = "Realms";
    VERSION = "0.4.1";
    PATCH = "Remove Nixd from Packages since its already in languages.";
  };

  packages = [
    pkgs.alejandra # Nix Formatter
    pkgs.git # Version Control
    pkgs.jujutsu # Better Version Control
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
