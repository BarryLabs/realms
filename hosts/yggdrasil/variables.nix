{
  lib,
  config,
  ...
}: {
  options.client = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };
  config.client = {
    host = "yggdrasil";
    user = "chandler";
    desc = "${config.client.host}'s user account";
    home = "/home/${config.client.user}";
    iniPass = "password";
    locale = "en_US.UTF-8";
    timezone = "America/New_York";
    ageFile = "/root/.config/sops/age/keys.txt";
    state = "25.11";
  };
}
