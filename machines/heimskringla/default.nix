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
      sops.enable = true;
    };
    profile = {
      server.enable = true;
    };
    svc = {
      homepage.enable = true;
    };
    oci = {
      changedetection.enable = true;
    };
  };
  sops = {
    secrets = {
      "tz" = {
        mode = "0400";
      };
    };
  };
}
