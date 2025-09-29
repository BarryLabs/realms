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
    host = "abyss";
    user = "mamotdask";
    desc = "${config.var.host}' user account";
    scpFont = "Source Code Pro";
    home = "/home/${config.var.user}";
    iniPass = "password";
    locale = "en_US.UTF-8";
    timezone = "America/New_York";
    state = "24.11";
    ageFile = "/root/.config/sops/age/keys.txt";
    i630Id = "PCI:01:00:0";
    d1660Id = "PCI:00:02:0";
    git = {
      username = "BarryLabs";
      email = "wave.carton247@aleeas.com";
    };
  };
}
