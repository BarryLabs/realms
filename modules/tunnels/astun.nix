{
  flake.nixosModules.astun = {
    sops = {
      secrets = {
        "newt/secret" = {
          sopsFile = ../../secrets/astun.yaml;
          mode = "0400";
        };
        "newt/id" = {
          sopsFile = ../../secrets/astun.yaml;
          mode = "0400";
        };
      };
    };
    services.newt = {
      enable = true;
      environmentFile = "/run/secrets/services/newt/secret";
      settings = {
        log-level = "DEBUG";
        id = "/run/secrets/services/newt/id";
        endpoint = "https://edge.barrylabs.cc";
      };
    };
  };
}
