{
  lib,
  config,
  ...
}: {
  options.yggdrasil = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };
  config.yggdrasil = {
    host = "yggdrasil";
    user = "chandler";
    desc = "${config.yggdrasil.host}'s account.";
    home = "/home/${config.yggdrasil.user}";
    iniPass = "password";
    locale = "en_US.UTF-8";
    timezone = "America/New_York";
    ageFile = "/root/.config/sops/age/keys.txt";
    state = "25.11";
  };
}
