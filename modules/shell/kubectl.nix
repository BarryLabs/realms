{
  flake.nixosModules.kubectl = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      kubectl
      (wrapHelm kubernetes-helm {
        plugins = with pkgs.kubernetes-helmPlugins; [
          helm-secrets
          helm-diff
          helm-s3
          helm-git
        ];
      }) 
    ];
  };
}
