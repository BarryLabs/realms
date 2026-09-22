{
  lib,
  config,
  ...
}: {
  options.bifrost = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };
  config.bifrost = {
    host = "bifrost";
    user = "heimdall";
    desc = "${config.bifrost.host}'s User Account.";
    home = "/home/${config.bifrost.user}";
    iniPass = "password";
    locale = "en_US.UTF-8";
    timezone = "America/New_York";
    ageFile = "/root/.config/sops/age/keys.txt";
    state = "25.11";
  };
}
