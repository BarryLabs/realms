{
  flake.nixosModules.minio-client = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      minio-client
    ];
  };
  flake.homeModules.minio-client = {pkgs, ...}: {
    home.packages = [
      pkgs.minio-client
    ];
  };
}
