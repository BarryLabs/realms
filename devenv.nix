{pkgs, config, ...}: {

  env = {
    VERSION = "0.4.0";
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
    alejandra --version
    git --version
    jj --version
    nixd --version
  '';

  tasks."realms:upload" = {
    exec = ''
      alejandra .
      jj bookmark set main
      jj commit -m "${toString config.env.VERSION}"
      jj git push
    '';
  };

}
