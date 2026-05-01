{
  flake.nixosModules.goose-cli = {pkgs, ...}: {
    environment.systemPackages = [pkgs.goose-cli];
  };
  flake.homeModules.goose-cli = {pkgs, ...}: {
    home.packages = with pkgs; [
      goose-cli
    ];
  };
}
