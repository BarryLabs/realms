{ lib
, config
, ...
}:
{
  options.var = lib.mkOption {
    type = lib.types.attrs;
    default = { };
  };
  config.var = {
    host = "yggdrasil";
    user = "chandler";
    desc = "${config.var.host}'s user account";
    gitname = "BarryLabs";
    gitemail = "wave.carton247@aleeas.com";
    home = "/home/${config.var.user}";
    iniPass = "password";
    locale = "en_US.UTF-8";
    timezone = "America/New_York";
    ageFile = "/root/.config/sops/age/keys.txt";
    state = "25.11";
  };
}
