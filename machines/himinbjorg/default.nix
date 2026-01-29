{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../profiles/system
    ../../modules/system
  ];
  augs = {
    profile = {
      server.enable = true;
      monitoring.enable = true;
    };
    com = {
      bootGRUB.enable = true;
      podman.enable = true;
      sops.enable = true;
    };
    oci = {
      newt.enable = true;
    };
  };
}
