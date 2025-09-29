{ pkgs
, config
, ...
}: {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
    flake = "/home/${config.var.user}/Projects/repos/Realms";
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}
