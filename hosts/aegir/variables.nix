{
  lib,
  config,
  ...
}: {
  options.aegir = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };
  config.aegir = {
    host = "aegir";
    user = "shiva";
    desc = "${config.aegir.host}'s account.";
    home = "/home/${config.aegir.user}";
    iniPass = "password";
    locale = "en_US.UTF-8";
    timezone = "America/New_York";
    ageFile = "/root/.config/sops/age/keys.txt";
    state = "25.11";
  };
}
