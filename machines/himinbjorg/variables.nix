{
  lib,
  config,
  ...
}:
{
  options.var = lib.mkOption {
    type = lib.types.attrs;
    default = { };
  };
  config.var = {
    host = "himinbjorg";
    user = "heimdall";
    desc = "Tun's User Account";
    home = "/home/${config.var.user}";
    iniPass = "password";
    locale = "en_US.UTF-8";
    timezone = "America/New_York";
    ageFile = "/root/.config/sops/age/keys.txt";
    state = "25.11";
  };
}
