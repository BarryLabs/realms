{
  lib,
  config,
  ...
}: {
  options.var = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };
  config.var = {
    host = "tesseract";
    user = "steve";
    desc = "Minecraft's User Account";
    home = "/home/${config.var.user}";
    iniPass = "password";
    locale = "en_US.UTF-8";
    timezone = "America/New_York";
    ageFile = "/root/.config/sops/age/keys.txt";
    state = "24.11";
  };
}
