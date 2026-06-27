{
  lib,
  config,
  ...
}: {
  options.abyss = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };
  config.abyss = {
    host = "abyss";
    user = "chandler";
    desc = "${config.abyss.host}'s account.";
    home = "/home/${config.abyss.user}";
    iniPass = "password";
    locale = "en_US.UTF-8";
    timezone = "America/New_York";
    ageFile = "/root/.config/sops/age/keys.txt";
    state = "26.11";
  };
}
