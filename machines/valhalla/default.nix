{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../modules/system
  ];
  augs = {
    profile = {
      server.enable = true;
      monitoring.enable = true;
    };
    svc = {
      home-assistant.enable = true;
    };
  };
}
