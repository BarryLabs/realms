{
  lib,
  config,
  ...
}: {
  options.asgard = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };
  config.asgard = {
    host = "asgard";
    user = "vault";
    desc = "${config.asgard.host}'s account.";
    home = "/home/${config.asgard.user}";
    iniPass = "password";
    locale = "en_US.UTF-8";
    timezone = "America/New_York";
    ageFile = "/root/.config/sops/age/keys.txt";
    state = "25.11";
  };
}
