{ self, ... }: {
  flake.nixosModules.talosctl = { pkgs, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.talosctl ];
  };

  flake.homeModules.talosctl = { pkgs, ... }: {
    home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.talosctl ];
  };

  perSystem = { pkgs, ... }: {
    packages.talosctl = pkgs.talosctl;
  };
}
