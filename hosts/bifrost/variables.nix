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
    desc = "${config.beluga.host}'s User Account.";
    home = "/home/${config.beluga.user}";
    iniPass = "password";
    locale = "en_US.UTF-8";
    timezone = "America/New_York";
    ageFile = "/root/.config/sops/age/keys.txt";
    state = "25.11";
  };
}
