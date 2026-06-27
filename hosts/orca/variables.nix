{
  lib,
  config,
  ...
}: {
  options.orca = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };
  config.orca = {
    host = "orca";
    user = "shamu";
    desc = "${config.orca.host}'s account.";
    home = "/home/${config.orca.user}";
    iniPass = "password";
    locale = "en_US.UTF-8";
    timezone = "America/New_York";
    ageFile = "/root/.config/sops/age/keys.txt";
    state = "25.11";
  };
}
