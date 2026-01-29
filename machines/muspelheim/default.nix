{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../profiles/system
    ../../modules/system
  ];
  augs = {
    com = {
      bootGRUB.enable = true;
      podman.enable = true;
    };
    profile = {
      server.enable = true;
      monitoring.enable = false;
    };
  };
}
