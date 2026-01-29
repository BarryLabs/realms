{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../profiles/system
    ../../modules/system
  ];
  augs = {
    com = {
      sops.enable = true;
    };
    profile = {
      server.enable = true;
      monitoring.enable = false;
    };
    oci = {
      home-assistant.enable = false;
    };
  };
  # sops.secrets = {
  #   "tz" = {
  #     mode = "0400";
  #   };
  # };
}
